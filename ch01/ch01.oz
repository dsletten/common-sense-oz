%%%
%%%   Name:               ch01.oz
%%%
%%%   Started:            Sat Mar 15 14:27:18 2025
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

declare
fun {ArrayFromList L}
   fun {AddElts L A I}
      case L
      of nil then A
      [] H|T then
         {Array.put A I H}
         {AddElts T A I+1}
      end
   end

   A = {NewArray 1 {Length L} nil}
in
   {AddElts L A 1}
end

declare
%ShoppingList = {Tuple.toArray ["apples" "bananas" "cucumbers" "dates" "elderberries"]}
ShoppingList = {ArrayFromList ["apples" "bananas" "cucumbers" "dates" "elderberries"]}

{System.showInfo {Array.get ShoppingList 3}}

declare
fun {Position A O}
   fun {Search I}
      if I > {Array.high A} then nil
      elseif O == {Array.get A I} then I
      else {Search I+1}
      end
   end
in
   {Search 1}
end

{Show {Position ShoppingList "dates"}}

declare
fun {Insert A I O}
   fun {InsertAt B I J}
{Show J}
      if J > {Array.high B} then
         B
      elseif J > I then
         {Array.put B J {Array.get A J-1}}
         {InsertAt B I J+1}
      elseif J == I then
         {Array.put B J O}
         {InsertAt B I J+1}
      else
         {Array.put B J {Array.get A J}}
         {InsertAt B I J+1}
      end
   end
   
   L = {Array.low A}
   H = {Array.high A}
in
   if I >= L andthen I =< H+1 then
      B = {NewArray L H+1 nil}
   in
      {InsertAt B I 1}
   else
      raise "Invalid index" end
   end
end

{Browse ShoppingList}
      

      
{System.showInfo {Array.get ShoppingList 3}}

for I in 1..5 do
   {System.showInfo {Array.get ShoppingList I}}
end

{Insert ShoppingList 1 "figs"}

declare
ShoppingList2 = {Insert ShoppingList 6 "figs"}
for I in 1..6 do
   {System.showInfo {Array.get ShoppingList2 I}}
end
{System.showInfo ""}

declare
fun {NewExtensibleArray L H Init}
   A = {NewCell {NewArray L H Init}}#Init
   proc {CheckOverflow I}
      Arr = @(A.1)
      Low = {Array.low Arr}
      High = {Array.high Arr}
   in
      if I > High then
         High2 = Low + {Max I 2 * (High - Low)}
         Arr2 = {NewArray Low High2 A.2}
      in
         for K in Low..High do Arr2.K := Arr.K end
         (A.1) := Arr2
      end
   end
   proc {Put I X}
      {CheckOverflow I}
      @(A.1).I := X
   end
   fun {Get I}
      {CheckOverflow I}
      @(A.1).I
   end
in
   extArray(get: Get put: Put)
end

declare
class ExtensibleArray
   attr store fillPointer:0
   meth init(size:Size<=20)
      store := {NewArray 0 Size-1 0}
   end
   meth get(I $)
      if I >= 0 andthen I < @fillPointer then
         {Array.get @store I}
      else
         raise "Invalid index: "#I end
      end
   end
   meth put(I Obj)
      if I >= 0 andthen I =< @fillPointer then
         if I == @fillPointer then
            fillPointer := @fillPointer + 1
         end
         {Array.put @store I Obj}
      else
         raise "Invalid index: "#I end
      end
   end
   meth size($)
      @fillPointer
   end
   meth search(Obj $)
      fun {Position I}
         if I > {self size($)} then nil
         elseif Obj == {self get(I $)} then I
         else {Position I+1}
         end
      end
   in
      {Position 0}
   end
   meth insert(I Obj)
      proc {Extend}
         High = {Array.high @store}
      in
         if @fillPointer > High then
            A = {NewArray 0 2 * (High + 1) nil}
         in
            {System.showInfo "Extending"#@fillPointer#" "#High#" "#{Array.high A}}
            for J in 0..High do A.J := (@store).J end
            store := A
         end
         fillPointer := @fillPointer + 1
      end
      proc {ShiftUp}
         {System.showInfo "Shifting"#@fillPointer#"|"#I}
         {self print}
         for J in (@fillPointer-1)..(I+1);~1 do (@store).J := (@store).(J-1) end
         {self print}
      end
   in
      if I >= 0 andthen I =< {self size($)} then
         {Extend}
         {ShiftUp}
         {self put(I Obj)}
      end
   end
   meth read(I $)
      {self get(I $)}
   end
   meth add(Obj)
      {self insert({self size($)} Obj)}
   end
   meth print
      {System.printInfo @fillPointer#"  "}
      for I in 0..{Array.high @store} do {System.printInfo @store.I#"|"} end
      {System.showInfo ""}
   end
end
