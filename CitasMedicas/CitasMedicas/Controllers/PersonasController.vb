Imports System.Data
Imports System.Data.Entity
Imports System.Data.Entity.Infrastructure
Imports System.Linq
Imports System.Net
Imports System.Net.Http
Imports System.Web.Http
Imports System.Web.Http.Description
Imports CitasMedicas
Imports Newtonsoft.Json

Namespace Controllers
  
    Public Class PersonasController

        Inherits System.Web.Http.ApiController

        Private db As New DB_GestionCitasEntities

        ' GET: api/Personas
        Function GetPersonas() As IQueryable(Of Personas)
            Return db.Personas
        End Function

        ' GET: api/Personas/5
        <ResponseType(GetType(Personas))>
        Function GetPersonas(ByVal id As Integer) As IHttpActionResult
            Dim personas As Personas = db.Personas.Find(id)
            If IsNothing(personas) Then
                Return NotFound()
            End If

            Return Ok(personas)
        End Function

        ' PUT: api/Personas/5
        <ResponseType(GetType(Void))>
        Function PutPersonas(ByVal id As Integer, ByVal personas As Personas) As IHttpActionResult
            If Not ModelState.IsValid Then
                Return BadRequest(ModelState)
            End If

            If Not id = personas.id Then
                Return BadRequest()
            End If

            db.Entry(personas).State = EntityState.Modified

            Try
                db.SaveChanges()
            Catch ex As DbUpdateConcurrencyException
                If Not (PersonasExists(id)) Then
                    Return NotFound()
                Else
                    Throw
                End If
            End Try

            Return StatusCode(HttpStatusCode.NoContent)
        End Function

        ' POST: api/Personas
        <ResponseType(GetType(Personas))>
        Function PostPersonas(ByVal personas As Personas) As IHttpActionResult
            If Not ModelState.IsValid Then
                Return BadRequest(ModelState)
            End If

            db.Personas.Add(personas)
            db.SaveChanges()

            Return CreatedAtRoute("DefaultApi", New With {.id = personas.id}, personas)
        End Function

        ' DELETE: api/Personas/5
        <ResponseType(GetType(Personas))>
        Function DeletePersonas(ByVal id As Integer) As IHttpActionResult
            Dim personas As Personas = db.Personas.Find(id)
            If IsNothing(personas) Then
                Return NotFound()
            End If

            db.Personas.Remove(personas)
            db.SaveChanges()

            Return Ok(personas)
        End Function

        Protected Overrides Sub Dispose(ByVal disposing As Boolean)
            If (disposing) Then
                db.Dispose()
            End If
            MyBase.Dispose(disposing)
        End Sub

        Private Function PersonasExists(ByVal id As Integer) As Boolean
            Return db.Personas.Count(Function(e) e.id = id) > 0
        End Function
    End Class
End Namespace