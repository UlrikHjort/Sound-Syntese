-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                            Triangle_Wave.ads                              --
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

package body Triangle_Wave is

   ----------------------------------------------------------------------
   -- Triangle wave Fouier serie:
   --
   -- F(x) =
   --
   ----------------------------------------------------------------------
   function Fourier(X : Float; Frequency : in Float; Sampling_Rate : Float) return Float is

      F_X : Float := 0.0;

   begin
      for K in 0 .. 100 loop
         F_X := F_X + ( Float((-1) ** K) * (Math.Sin( ((2.0 * Float(K)) +1.0) * Frequency * X) / (((2.0 * Float(K)) +1.0) ** 2)));
      end loop;
      return ((8.0/(PI ** 2)) * F_X);
   end Fourier;


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Frequency : in Float;
                      Amplitude : in Float;
                      Wave_File : in out Wave_File_T) is

  begin
       for X in 1 .. Wave_File.Data'Length loop
          Wave_File.Data(X) := Data_Type(Fourier(Float(X), Frequency, Float(Wave_File.Header.SampleRate)) *  Amplitude / 2.0);
       end loop;
  end Generate;
end Triangle_Wave;
