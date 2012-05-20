-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                            Delay_Effect.adb                               --
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
with Ada.Text_IO; use Ada.Text_IO;

package body Delay_Effect is

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Wave_File : in out Wave_File_T) is

   begin
      for J in 1 .. 20 loop
     for I in 1 .. Natural(Wave_File.Data'Length / 2) loop

        Wave_File.Data(I+10000) :=
          Data_Type((Float(
                             Wave_File.Data(I) +
                             Wave_File.Data(Natural(Wave_File.Data'Length / 2)+I)
                          ))
                    / 2.0);
     end loop;
     end loop;
  end Generate;
end Delay_Effect;

