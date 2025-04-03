%%%
%%%   Name:               ExtensibleArray.oz
%%%
%%%   Started:            Mon Mar 24 01:41:25 2025
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
%%%   Notes: CTMCP 439 页
%%%
%%%

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
