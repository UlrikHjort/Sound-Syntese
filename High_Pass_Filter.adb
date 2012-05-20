-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                          High_Pass_Filter.adb                             --
--                                                                           --
--                                 BODY                                      --
--                                                                           --
--                   Copyright (C) 1996 Ulrik Hørlyk Hjort                   --
--                                                                           --
--  Sound Syntese is free software;  you can  redistribute it                --
--  and/or modify it under terms of the  GNU General Public License          --
--  as published  by the Free Software  Foundation;  either version 2,       --
--  or (at your option) any later version.                                   --
--  Sound Syntese is distributed in the hope that it will be                 --
--  useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty    --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  --
--  See the GNU General Public License for  more details.                    --
--  You should have  received  a copy of the GNU General                     --
--  Public License  distributed with Yolk.  If not, write  to  the  Free     --
--  Software Foundation,  51  Franklin  Street,  Fifth  Floor, Boston,       --
--  MA 02110 - 1301, USA.                                                    --
--                                                                           --
-------------------------------------------------------------------------------
with Constants; use Constants;
package body High_Pass_Filter is

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Cutoff_Frequency : in Float;
                      Wave_File        : in out Wave_File_T) is

      RC : constant Float := 1.0 / (2.0 * PI * Cutoff_Frequency);
      Dt : constant Float := 0.5;
      A  : constant Float := RC / (RC + Dt);

      Tmp : Dynamic_Wave_Data_Buffer_Access := new Dynamic_Wave_Data_Buffer(1.. Wave_File.Data'Length);

   begin
      -- Copy Buffer
      for I in 1 .. Wave_File.Data'Length loop
         Tmp(I) := Wave_File.Data(I);
      end loop;

      Wave_File.Data(1) := 0;
      for I in 2 .. Wave_File.Data'Length loop
         Wave_File.Data(I) := Data_Type(A * Float(Wave_File.Data(I-1) + Tmp(I) - Tmp(I-1)));
      end loop;
  end Generate;
end High_Pass_Filter;
