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
    Public Class RecetasController
        Inherits System.Web.Http.ApiController

        Private db As New DB_GestionCitasEntities

        ' GET: api/Recetas
        Function GetRecetas() As IQueryable(Of Recetas)
            Return db.Recetas
        End Function

        ' GET: api/Recetas/5
        <ResponseType(GetType(Recetas))>
        Function GetRecetas(ByVal id As Integer) As IHttpActionResult
            Dim recetas As Recetas = db.Recetas.Find(id)
            If IsNothing(recetas) Then
                Return NotFound()
            End If

            Return Ok(recetas)
        End Function

        ' PUT: api/Recetas/5
        <ResponseType(GetType(Void))>
        Function PutRecetas(ByVal id As Integer, ByVal recetas As Recetas) As IHttpActionResult
            If Not ModelState.IsValid Then
                Return BadRequest(ModelState)
            End If

            If Not id = recetas.id_receta Then
                Return BadRequest()
            End If

            db.Entry(recetas).State = EntityState.Modified

            Try
                db.SaveChanges()
            Catch ex As DbUpdateConcurrencyException
                If Not (RecetasExists(id)) Then
                    Return NotFound()
                Else
                    Throw
                End If
            End Try

            Return StatusCode(HttpStatusCode.NoContent)
        End Function

        ' POST: api/Recetas
        <ResponseType(GetType(Recetas))>
        Function PostRecetas(ByVal recetas As Recetas) As IHttpActionResult
            If Not ModelState.IsValid Then
                Return BadRequest(ModelState)
            End If

            db.Recetas.Add(recetas)
            db.SaveChanges()

            Return CreatedAtRoute("DefaultApi", New With {.id = recetas.id_receta}, recetas)
        End Function

        ' DELETE: api/Recetas/5
        <ResponseType(GetType(Recetas))>
        Function DeleteRecetas(ByVal id As Integer) As IHttpActionResult
            Dim recetas As Recetas = db.Recetas.Find(id)
            If IsNothing(recetas) Then
                Return NotFound()
            End If

            db.Recetas.Remove(recetas)
            db.SaveChanges()

            Return Ok(recetas)
        End Function

        Protected Overrides Sub Dispose(ByVal disposing As Boolean)
            If (disposing) Then
                db.Dispose()
            End If
            MyBase.Dispose(disposing)
        End Sub

        Private Function RecetasExists(ByVal id As Integer) As Boolean
            Return db.Recetas.Count(Function(e) e.id_receta = id) > 0
        End Function
    End Class
End Namespace