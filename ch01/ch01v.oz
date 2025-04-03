%%%
%%%   Name:               ch01v.oz
%%%
%%%   Started:            Sat Mar 29 21:13:28 2025
%%%   Modifications:
%%%
%%%   Purpose:
%%%
%%%
%%%
%%%   Calling Sequence:
%%%
%%%
%%%   Inputs:
%%%
%%%   Outputs:
%%%
%%%   Example:
%%%
%%%   Notes:
%%%
%%%

functor
import
   Application
   System
   Vector at 'file:///home/slytobias/oz/modules/Vector.ozf'

define
   proc {PrintShoppingList L}
      Size = {L size($)}
   in
      {System.printInfo "Shopping list: "}
      for I in 0..Size-2 do
         {System.printInfo {L elt(I $)}#", "}
      end
      {System.showInfo {L elt(Size-1 $)}}
   end

   ShoppingList = {Vector.makeVector 5}
   
   for Elt in ["apples" "bananas" "cucumbers" "dates" "elderberries"] do
      {ShoppingList add(Elt)}
   end

   {PrintShoppingList ShoppingList}
   {System.showInfo "Element at index 2: "#{ShoppingList elt(2 $)}}
   {System.showInfo "Index of element \"dates\": "#{ShoppingList position("dates" $)}}

   {System.showInfo "Add \"figs\" to list."}
   {ShoppingList insert(2 "figs")}
   {PrintShoppingList ShoppingList}

   {System.showInfo "Remove element at index 3: "#{ShoppingList delete(3 $)}}
   {PrintShoppingList ShoppingList}

   {System.showInfo "Add more \"figs\" to list."}
   {ShoppingList insert(0 "figs")}
   {PrintShoppingList ShoppingList}

   {Application.exit 0}
end