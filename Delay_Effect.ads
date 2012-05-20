-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                            Delay_Effect.ads                               --
--                                                                           --
--                                 SPEC                                      --
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
with Interfaces; use Interfaces;
with Wave_Io; use Wave_Io;
package Delay_Effect is

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Wave_File : in out Wave_File_T);
end Delay_Effect;
