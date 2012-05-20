-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                            White_Noise.adb                                 --
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

with Ada.Numerics.Discrete_Random; use Ada.Numerics;

package body White_Noise is

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Amplitude : in Float;Wave_File : in out Wave_File_T) is

   subtype Random_Interval is Natural range 0..Natural'Last;
   package Random_Natural is new Discrete_Random(Random_Interval);
   use Random_Natural;

   G : Generator;
   X : Float := 0.0;

  begin

     for I in 1 .. Wave_File.Data'Length loop
        X := Float(Random(G))/Float(Natural'Last);
        Wave_File.Data(I) := Data_Type(X * Amplitude / 2.0);
     end loop;

  end Generate;
end White_Noise;
