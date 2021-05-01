VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UF_Aux_Pedido 
   Caption         =   "Selección de Productos y Paquetería"
   ClientHeight    =   6735
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6375
   OleObjectBlob   =   "UF_Aux_Pedido.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "UF_Aux_Pedido"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub UserForm_Initialize()

    'Quita el la cruz para cerrar la ventana
    Call SystemButtonSettings(Me, False)

    Dim ventas_aux_row As Integer
    ventas_aux_row = Sheets("Auxiliar").Range("B8").Value
    
    'checar si se han ingresado productos para permitir
    'que se finalice la orden o que se agregen productos
    If ventas_aux_row = 0 Then
        Me.Cancelar_Producto.Enabled = False
        Me.Finalizar_Pedido.Enabled = False
    Else
        Me.Cancelar_Producto.Enabled = True
        Me.Finalizar_Pedido.Enabled = True
    End If
    
    
End Sub

Private Sub Agregar_Producto_Click()

    Dim ventas_aux_row, pvp As Integer
    
    If Me.Descuento = "" Then
        Me.Descuento = 0
    End If
    
    ventas_aux_row = Sheets("Auxiliar").Range("B8").Value
    pvp = Sheets("Productos").Range("A:A").Find(Me.Producto).Offset(0, 4)
    
    'Llenar una fila de ventas aux
    With Sheets("Auxiliar").Range("T2")
        .Offset(ventas_aux_row, 0).Value = Me.Producto
        .Offset(ventas_aux_row, 1).Value = Me.Cantidad_Producto
        .Offset(ventas_aux_row, 2).Value = pvp
        .Offset(ventas_aux_row, 3).Value = Me.Paquete
        .Offset(ventas_aux_row, 4).Value = Me.Cantidad_Paquete
        .Offset(ventas_aux_row, 5).Value = Me.Descuento
        .Offset(ventas_aux_row, 6).Value = pvp * Me.Cantidad_Producto * (1 - Me.Descuento)
    End With
    
    'llenar una fila de lista
    With Sheets("Auxiliar").Range("AB2")
        .Offset(ventas_aux_row, 0).Value = Me.Producto
        .Offset(ventas_aux_row, 1).Value = Sheets("Productos").Range("A:A").Find(Me.Producto).Offset(0, 1)
        .Offset(ventas_aux_row, 2).Value = Me.Cantidad_Producto
        .Offset(ventas_aux_row, 3).Value = pvp
    End With
    
    Me.Hide
    Unload Me
    UF_Aux_Pedido.show
        
End Sub

Private Sub Cancelar_Producto_Click()
    
    UF_Editar_Productos.show
    
End Sub

Private Sub Cancelar_Pedido_Click()

    Dim ventas_aux_row As Integer
    ventas_aux_row = Sheets("Auxiliar").Range("B8").Value
    
    'borra todas las filas de ventas aux y de lista
    'la última fila de esas tablas y la fila de pedidos solo se vacía
    Dim i As Integer
    For i = 0 To ventas_aux_row - 1
        If i - ventas_aux_row = 1 Then
            Sheets("Auxiliar").Range("T2").Clear
        Else
            Sheets("Auxiliar").Range("T2").Delete Shift:=xlUp
            Sheets("Auxiliar").Range("AB2").Delete Shift:=xlUp
        End If
    Next i
    
    Sheets("Auxiliar").Range("K2:R2").Clear
    
    Unload Me

End Sub

Private Sub Finalizar_Pedido_Click()
    
    UF_Finalizar_Pedido.show
    
End Sub
