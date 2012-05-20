-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                             Square_Wave.adb                               --
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


package body Square_Wave is

   ----------------------------------------------------------------------
   -- Square wave Fouier serie:
   --
   -- F(x) = (4/PI) * SUM(SIN((2k-1) * 2 * PI * F *T) / (2k-1))
   --
   ----------------------------------------------------------------------
   function Fourier(X : Float; Frequency : in Float; Sampling_Rate : Float) return Float is

      F_X : Float := 0.0;

   begin
      for K in 1 .. 100 loop
         F_X := F_X + ((Math.Sin( ((2.0*Float(K)) -1.0) * 2.0 * PI * Frequency * X / Sampling_Rate)) / ((2.0*Float(K)) - 1.0));
      end loop;
      return ((4.0/PI) * F_X);
   end Fourier;

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Generate(Frequency : in Float; Amplitude : in Float; Sampling_Rate : in Unsigned_32; Wave_Data_Buffer : in out Dynamic_Wave_Data_Buffer_Access) is
    begin
       for X in 1 .. Wave_Data_Buffer'Length loop
          Wave_Data_Buffer(X) := Data_Type(Fourier(Float(X), Frequency, Float(Sampling_Rate)) *  Amplitude / 2.0);
       end loop;
    end Generate;
  end Square_Wave;
