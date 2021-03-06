-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                          Distortion_Effect.adb                            --
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

package body Distortion_Effect is

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Low_Threshold    : Data_Type;
                      High_Threshold   : Data_Type;
                      Wave_File        : in out Wave_File_T) is

   begin
      for X in 1 .. Wave_File.Data'Length loop
         if Wave_File.Data(X) < Low_Threshold then
            Wave_File.Data(X) := Low_Threshold;
         end if;
         if Wave_File.Data(X) > High_Threshold then
            Wave_File.Data(X) := High_Threshold;
         end if;
     end loop;
   end Generate;
end Distortion_Effect;
