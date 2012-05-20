-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                            Test_Package.adb                               --
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
with Interfaces; use Interfaces;
with Ada.Text_IO; use Ada.Text_IO;
with Wave_Io; use Wave_Io;
with Wave_Tools;

with Sine_Wave;
with Square_Wave;
with Sawtooth_Wave;
with Triangle_Wave;

with White_Noise;

with Delay_Effect;
with Distortion_Effect;

with High_Pass_Filter;
with Volume_Filter;

package body Test_Package is

-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure Harmony_Test is
   Wave_File1 : Wave_File_T;
   Wave_File2 : Wave_File_T;
   Wave_File3 : Wave_File_T;

   Freq : Float := 0.0;
   Sample_Rate : Unsigned_32 := 11025;

begin
   Init_Header(Wave_File1);
   Update_Header(Wave_File1, Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File1);

   Init_Header(Wave_File2);
   Update_Header(Wave_File2, Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File2);

   Init_Header(Wave_File3);
   Update_Header(Wave_File3, Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File3);

   Sine_Wave.Generate(50.0, 8000.0, Wave_File1);
   Sine_Wave.Generate(1000.0, 8000.0, Wave_File2);
   Wave_Tools.Add(Wave_File1, Wave_File2, Wave_File3);

   Sine_Wave.Generate(100.0, 8000.0,  Wave_File2);
   Wave_Tools.Add(Wave_File3, Wave_File2, Wave_File1);
   Save("./lyd/W11.wav", Wave_File1);
   DeAllocate(Wave_File1);
   DeAllocate(Wave_File2);
   DeAllocate(Wave_File3);
end Harmony_Test;


-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure Volume_Test is
   Wave_File : Wave_File_T;

begin
   Load("./lyd/Piano.wav", Wave_File);
   Wave_Info(Wave_File);
   Volume_Filter.Generate(0.5, Wave_File);
   Save("./lyd/W11.wav", Wave_File);
   DeAllocate(Wave_File);
end Volume_Test;




-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure Distortion_Test is
   Wave_File : Wave_File_T;

begin
   Load("./lyd/G1.wav", Wave_File);
   Wave_Info(Wave_File);
   Delay_Effect.Generate(Wave_File);
   Distortion_Effect.Generate(-6000, 6000,Wave_File);
   Save("./lyd/W11.wav", Wave_File);
   DeAllocate(Wave_File);
end Distortion_Test;




-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure High_Pass_Test is
   Wave_File : Wave_File_T;
   Sample_Rate : Unsigned_32 := 11025;

begin
   Init_Header(Wave_File);
   Update_Header(Wave_File,Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File);
   Sine_Wave.Generate(5000.0, 8000.0, Wave_File);
   High_Pass_Filter.Generate(200.0, Wave_File);
   Save("./lyd/W11.wav", Wave_File);
   DeAllocate(Wave_File);
end High_Pass_Test;



-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure White_Noise_Test is
   Wave_File : Wave_File_T;
   Sample_Rate : Unsigned_32 := 11025;

begin
   Init_Header(Wave_File);
   Update_Header(Wave_File, Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File);

   White_Noise.Generate(8000.0, Wave_file);
   Save("./lyd/W11.wav", Wave_File);
   DeAllocate(Wave_File);
end White_Noise_Test;



-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure Triangle_Wave_Test is
   Wave_File : Wave_File_T;
   Sample_Rate : Unsigned_32 := 11025;

begin
   Init_Header(Wave_File);
   Update_Header(Wave_File, Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File);

   Triangle_Wave.Generate(500.0, 8000.0,Wave_File);
   Save("./lyd/W11.wav", Wave_File);
   Dump_Wave_Data(Wave_File);
   DeAllocate(Wave_File);
end Triangle_Wave_Test;



-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure Sine_Wave_Test is
   Wave_File : Wave_File_T;
   Freq : Float := 0.0;
   Sample_Rate : Unsigned_32 := 11025;

begin
   Init_Header(Wave_File);
   Update_Header(Wave_File, Sample_Rate, 1, 80000);
   Allocate_Data_Buffer(Wave_File);

   Sine_Wave.Generate(500.0, 8000.0, Wave_File);
   Freq := Wave_Tools.Wave_Frequency(Wave_File);
   Put_Line("Freq: " & Integer'Image(Integer(Freq)));
   Save("./lyd/W11.wav", Wave_File);
   DeAllocate(Wave_File);
end Sine_Wave_Test;



-------------------------------------------------------------------------
--
-------------------------------------------------------------------------
procedure Delay_Test is
   Wave_File : Wave_File_T;

begin
   Load("./lyd/Piano.wav", Wave_File);
   Wave_Info(Wave_File);
   Delay_Effect.Generate(Wave_File);
   Save("./lyd/W11.wav", Wave_File);
   DeAllocate(Wave_File);
end Delay_Test;



-------------------------------------------------------------------------
--
-------------------------------------------------------------------------


end Test_Package;
