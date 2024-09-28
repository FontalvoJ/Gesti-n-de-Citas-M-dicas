Imports System.Data
Imports System.Data.Entity
Imports System.Data.Entity.Infrastructure
Imports System.Linq
Imports System.Net
Imports System.Net.Http
Imports System.Web.Http
Imports System.Web.Http.Description
Imports CitasMedicas

Namespace Controllers
    Public Class CitasController
        Inherits System.Web.Http.ApiController

        Private db As New DB_GestionCitasEntities

        ' GET: api/Citas
        Function GetCitas() As IQueryable(Of Citas)
            Return db.Citas
        End Function

        ' GET: api/Citas/5
        <ResponseType(GetType(Citas))>
        Function GetCitas(ByVal id As Integer) As IHttpActionResult
            Dim citas As Citas = db.Citas.Find(id)
            If IsNothing(citas) Then
                Return NotFound()
            End If

            Return Ok(citas)
        End Function

        ' PUT: api/Citas/5
        <ResponseType(GetType(Void))>
        Function PutCitas(ByVal id As Integer, ByVal citas As Citas) As IHttpActionResult
            If Not ModelState.IsValid Then
                Return BadRequest(ModelState)
            End If

            If Not id = citas.id_cita Then
                Return BadRequest("El ID de la cita no coincide con el ID proporcionado.")
            End If

            db.Entry(citas).State = EntityState.Modified

            Try
                db.SaveChanges()
            Catch ex As DbUpdateConcurrencyException
                If Not CitasExists(id) Then
                    Return NotFound()
                Else
                    Throw
                End If
            End Try

            Return Ok("Cita actualizada correctamente.")
        End Function

        ' POST: api/Citas
        <ResponseType(GetType(Citas))>
        Function PostCitas(ByVal citas As Citas) As IHttpActionResult
            If Not ModelState.IsValid Then
                Return BadRequest(ModelState)
            End If

            db.Citas.Add(citas)
            db.SaveChanges()

            Return CreatedAtRoute("DefaultApi", New With {.id = citas.id_cita}, citas, "Cita creada exitosamente.")
        End Function

        ' DELETE: api/Citas/5
        <ResponseType(GetType(Citas))>
        Function DeleteCitas(ByVal id As Integer) As IHttpActionResult
            Dim citas As Citas = db.Citas.Find(id)
            If IsNothing(citas) Then
                Return NotFound()
            End If

            db.Citas.Remove(citas)
            db.SaveChanges()

            Return Ok("Cita eliminada exitosamente.")
        End Function

        Protected Overrides Sub Dispose(ByVal disposing As Boolean)
            If (disposing) Then
                db.Dispose()
            End If
            MyBase.Dispose(disposing)
        End Sub

        Private Function CitasExists(ByVal id As Integer) As Boolean
            Return db.Citas.Count(Function(e) e.id_cita = id) > 0
        End Function
    End Class
End Namespace
