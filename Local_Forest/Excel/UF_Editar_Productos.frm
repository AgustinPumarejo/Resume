VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UF_Editar_Productos 
   Caption         =   "Borrar Productos"
   ClientHeight    =   3015
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6375
   OleObjectBlob   =   "UF_Editar_Productos.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "UF_Editar_Productos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub UserForm_Initialize()

    'Quita el la cruz para cerrar la ventana
    Call SystemButtonSettings(Me, False)
    
    'actualiza los valores de la lista ya que
    'si no se quedan los de antes de hacer el pedido
    Me.Lista.RowSource = "Lista_Productos[[ID Producto]:[Cantidad]]"

End Sub

Private Sub Borrar_Productos_Click()

    Dim num_rows As Integer
    num_rows = 0
    
    'cuenta el número de productos seleccionados para crear un arreglo despues
    Dim i As Integer
    For i = 0 To Me.Lista.ListCount - 1
        If Me.Lista.Selected(i) = True Then
            num_rows = num_rows + 1
        End If
    Next i
    
    Dim borrar_pedidos(), indice As Integer
    ReDim borrar_pedidos(num_rows - 1)
    indice = 0
    
    'añade cada producto al arreglo
    For i = 0 To Me.Lista.ListCount - 1
        If Me.Lista.Selected(i) = True Then
            borrar_pedidos(indice) = Me.Lista.List(i)
            MsgBox "Added " & Me.Lista.List(i)
            indice = indice + 1
        End If
    Next i
    
    Dim row As Integer
    
    'borra cada producto dentro del arreglo
    For i = 0 To UBound(borrar_pedidos)
        row = Sheets("Auxiliar").Range("T:T").Find(borrar_pedidos(i)).row
        Sheets("Auxiliar").Range("T" & row).Delete Shift:=xlUp
        Sheets("Auxiliar").Range("AB" & row).Delete Shift:=xlUp
    Next i
    
    Me.Hide

End Sub

Private Sub Cancelar_Click()

    Me.Hide

End Sub
