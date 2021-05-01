VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UF_Insertar_Pedido 
   Caption         =   "Insertar Pedido"
   ClientHeight    =   6495
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4695
   OleObjectBlob   =   "UF_Insertar_Pedido.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "UF_Insertar_Pedido"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Btn_Insertar_Click()

    Dim pedidos_row As Integer
    
    If Me.Descuento = "" Then
        Me.Descuento = 0
    End If
    
    pedidos_row = Sheets("Auxiliar").Range("B6").Value
    
    'Llenar primeras columnas de pedido auxiliar
    With Sheets("Auxiliar").Range("K2")
        .Offset(0, 0).Value = Sheets("Pedidos").Range("A2").Offset(pedidos_row, 0).row - 1
        .Offset(0, 1).Value = Me.Nombre_Cliente
        .Offset(0, 2).Value = Me.Día_Pedido & "/" & Me.Mes_Pedido & "/" & Me.Año_Pedido
        .Offset(0, 3).Value = Me.Día_Entrega & "/" & Me.Mes_Entrega & "/" & Me.Año_Entrega
        .Offset(0, 4).Value = Me.Descuento
    End With
    
    Unload Me
    UF_Aux_Pedido.show

End Sub

Private Sub Btn_Cancelar_Click()
    
    Unload Me
    
End Sub
