VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UF_Finalizar_Pedido 
   Caption         =   "Finalizar Pedido"
   ClientHeight    =   1575
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4575
   OleObjectBlob   =   "UF_Finalizar_Pedido.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "UF_Finalizar_Pedido"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub UserForm_Initialize()

    'Quita el la cruz para cerrar la ventana
    Call SystemButtonSettings(Me, False)
    
    Dim ventas_aux_row, Total As Integer
    ventas_aux_row = Sheets("Auxiliar").Range("B8").Value
    
    'calcula el total del pedido
    Total = Application.WorksheetFunction.Sum(Sheets("Auxiliar").Range("Z2:Z" & ventas_aux_row + 2)) _
    * (1 - Sheets("Auxiliar").Range("O2").Value)
    
    Sheets("Auxiliar").Range("P2").Value = Total
    Sheets("Auxiliar").Range("Q2:R2").Value = False
    
    Dim cuentas As String
    Dim altura As Integer
    cuentas = ""
    altura = 24
    
    'crea la lista de compras y actualiza la altura del cuadro de texto
    Dim i As Integer
    For i = 0 To ventas_aux_row - 1
        cuentas = cuentas & Sheets("Auxiliar").Range("AC" & i + 2).Value _
                & " x" & Sheets("Auxiliar").Range("AD" & i + 2).Value _
                & "     = " & Sheets("Auxiliar").Range("Z" & i + 2).Value & vbNewLine
        altura = altura + 18
    Next i
    
    cuentas = cuentas & "___________" & vbNewLine & Total
    Me.Total.Height = altura
    Me.Height = 84 + altura
    Me.Total.Caption = cuentas

End Sub
Private Sub Aceptar_Click()
    
    Dim ventas_aux_row, ventas_row, pedidos_row As Integer
    ventas_aux_row = Sheets("Auxiliar").Range("B8").Value
    ventas_row = Sheets("Auxiliar").Range("B7").Value
    pedidos_row = Sheets("Auxiliar").Range("B6").Value
    
    'encuentra el rango donde se tienen que insertar los datos en cada columna
    'y asigna ahí los datos de las tablas auxiliares
    Sheets("Ventas").Range("B" & ventas_row + 2 & ":H" & ventas_aux_row + ventas_row + 1).Value = _
    Sheets("Auxiliar").Range("T2:Z" & ventas_aux_row + 1).Value
    Sheets("Ventas").Range("A" & ventas_row + 2 & ":A" & ventas_aux_row + ventas_row + 1).Value = _
    Sheets("Auxiliar").Range("K2").Value
    
    Sheets("Pedidos").Range("A" & pedidos_row + 2 & ":H" & pedidos_row + 2).Value = _
    Sheets("Auxiliar").Range("K2:R2").Value
    
    MsgBox "Filas insertadas exitosamente", 0, "¡Éxito!"
    
    'encuentra los productos en el inventario, actualiza la existencia
    'y despues vacía los datos como en cancelar pedido
    Dim existencia As Range
    
    Dim i As Integer
    For i = 0 To ventas_aux_row - 1
        If i - ventas_aux_row = 0 Then
            Set existencia = Sheets("Productos").Range("A:A") _
            .Find(Sheets("Auxiliar").Range("T2")).Offset(0, 2)
            existencia.Value = existencia.Value - Sheets("Auxiliar").Range("U2").Value
            
            Sheets("Auxiliar").Range("S2").Clear
        Else
            Set existencia = Sheets("Productos").Range("A:A") _
            .Find(Sheets("Auxiliar").Range("T2")).Offset(0, 2)
            existencia.Value = existencia.Value - Sheets("Auxiliar").Range("U2").Value
            
            Sheets("Auxiliar").Range("T2").Delete Shift:=xlUp
            Sheets("Auxiliar").Range("AB2").Delete Shift:=xlUp
        End If
    Next i
    
    Sheets("Auxiliar").Range("K2:R2").Clear
    
    Unload Me
    Unload UF_Aux_Pedido
        
End Sub

Private Sub Regresar_Click()

Unload Me

End Sub
