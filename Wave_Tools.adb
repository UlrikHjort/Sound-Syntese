-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                             Wave_Tools.adb                                --
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
package body Wave_Tools is

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   function Wave_Frequency(Wave_File : in Wave_File_T) return Float is

      Frequency : Float     := 0.0;
      Start     : Data_Type := Wave_File.Data(1);
      End_Pos   : Natural   := 0;

   begin
      for I in 2 .. Wave_File.Data'Length loop
         End_Pos := I;
         exit when Wave_File.Data(I) = Start;
      end loop;

      Frequency := (1.0 / (Float(End_Pos+1) / Float(Wave_File.Header.SampleRate))) * 2.0;
      return Frequency;
   end Wave_Frequency;


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Add(W1 : in  Wave_File_T;
                 W2 : in  Wave_File_T;
                 W_out : out Wave_File_T) is

  begin
     for I in 1 .. W_Out.Data'Length loop
          W_Out.Data(I) := Data_Type( Float(W1.Data(I) + W2.Data(I)) / 2.0 );
     end loop;
  end Add;
end Wave_Tools;
