%%%
%%%   Name:               ArraySet.oz
%%%
%%%   Started:            Sun Mar 30 23:52:03 2025
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
   Vector at 'file:///home/slytobias/oz/modules/Vector.ozf'
export
   MakeArraySet

define
   class ArraySet
%      attr store:{Vector.makeVector 20} index:{NewDictionary} needsRehash:false
      attr store index needsRehash
      meth init
         store := {Vector.makeVector 20}
         index := {NewDictionary}
         needsRehash := false
      end
      meth size($)
         {@store size($)}
      end
      meth insert(I Obj)
         if 0 =< I andthen I =< {self size($)} then
            O = {String.toAtom Obj}
         in
            if {Not {Dictionary.member @index O}} then
               {@store insert(I Obj)}
               {Dictionary.put @index O I}
               needsRehash := true
            end
         else
            raise "Invalid index: "#I end
         end
      end
      meth add(Obj)
         {self insert({self size($)} Obj)}
      end
      meth read(I $)
         if 0 =< I andthen I =< {self size($)} - 1 then
            {@store elt(I $)}
         else
            raise "Invalid index: "#I end
         end
      end
   end

   fun {MakeArraySet Contents}
      AS = {New ArraySet init}
   in
      for Item in Contents do
         {AS add(Item)}
      end
      AS
   end
end