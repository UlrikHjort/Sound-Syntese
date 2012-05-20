-------------------------------------------------------------------------------
--                                                                           --
--                             Sound Syntese                                 --
--                                                                           --
--                               Wave_Io.adb                                 --
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
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Unchecked_Deallocation;

package body Wave_Io is


   My_File        : Ada.Streams.Stream_IO.FILE_TYPE;
   My_File_Access : Ada.Streams.Stream_IO.STREAM_ACCESS;

   Chunck_Divider : constant Unsigned_32 := 2;

   procedure Delete_Data_Buffer is new Ada.Unchecked_Deallocation
     (Dynamic_Wave_Data_Buffer, Dynamic_Wave_Data_Buffer_Access);


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Allocate_Data_Buffer(Wave_File : out Wave_File_T) is
   begin
      Wave_File.Data :=
        new Dynamic_Wave_Data_Buffer(1.. Natural(Wave_File.Header.Subchunk2Size));
   end Allocate_Data_Buffer;


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Wave_Info(Wave_File : in Wave_File_T) is

   begin
      Put_Line("Chunk Size: " & Unsigned_32'Image(Wave_File.Header.Chunk_Size));
      Put_Line("SubChunk1 Size: " & Unsigned_32'Image(Wave_File.Header.Subchunk1Size));
      Put_Line("Audio Format PCM=: " & Unsigned_16'Image(Wave_File.Header.AudioFormat));
      Put_Line("Number Of Channels: " & Unsigned_16'Image(Wave_File.Header.NumChannels));
      Put_Line("Sample Rate: " & Unsigned_32'Image(Wave_File.Header.SampleRate));
      Put_Line("Byte Rate: " & Unsigned_32'Image(Wave_File.Header.ByteRate));
      Put_Line("Block Align: " & Unsigned_16'Image(Wave_File.Header.BlockAlign));
      Put_Line("Bits Per Sample: " & Unsigned_16'Image(Wave_File.Header.BitsPerSample));
      Put_Line("SubChunk2 Size: " & Unsigned_32'Image(Wave_File.Header.Subchunk2Size));
      Put_Line("----------------------------------");
      Put_Line("Sample Duration: " & Float'Image(Float(Wave_File.Header.Subchunk2Size) / Float(Wave_File.Header.SampleRate)));
   end Wave_Info;



   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure DeAllocate(Wave_File : in out Wave_File_T) is
   begin
      Delete_Data_Buffer(Wave_File.Data);
   end DeAllocate;


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Load(File_Name : in String; Wave_File : in out Wave_File_T) is
--   procedure Load(File_Name : in String; Wave_Header : in out Wave_Header_Type; Wave_Data_Buffer : in out Dynamic_Wave_Data_Buffer_Access) is

   begin
      Open(My_File, In_File, File_Name);
      My_File_Access := Stream(My_File);
      Wave_Header_Type'Read(My_File_Access, Wave_File.Header);
      Wave_File.Data := new Dynamic_Wave_Data_Buffer(1.. Natural(Wave_File.Header.Subchunk2Size/Chunck_Divider));
      --      Dynamic_Wave_Data_Buffer_Access'Read(My_File_Access, Wave_Data_Buffer);

      declare
         Buffer : Dynamic_Wave_Data_Buffer(1..Natural(Wave_File.Header.Subchunk2Size/Chunck_Divider));
      begin
         Dynamic_Wave_Data_Buffer'Read(My_File_Access, Buffer);
         for I in 1 .. Natural(Wave_File.Header.Subchunk2Size/Chunck_Divider) loop
            Wave_File.Data(I) := Buffer(I);
         end loop;
      end;
     Close(My_File);
   end Load;

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Save(File_Name : in String; Wave_File : in Wave_File_T) is

   begin
      Ada.Streams.Stream_IO.Create(My_File, Out_File, File_Name);
      My_File_Access := Ada.Streams.Stream_IO.Stream(My_File);
      Wave_Header_Type'Write(My_File_Access, Wave_File.Header);

      declare
        Buffer : Dynamic_Wave_Data_Buffer(1..Natural(Wave_File.Header.Subchunk2Size/Chunck_Divider));

      begin
         for I in 1 .. Natural(Wave_File.Header.Subchunk2Size/Chunck_Divider) loop
            Buffer(I) := Wave_File.Data(I);
         end loop;
         Dynamic_Wave_Data_Buffer'Write(My_File_Access, Buffer);
      end;
      Close(My_File);
   end Save;

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Init_Header(Wave_File : out Wave_File_T) is

   begin
      Wave_File.Header.RIFF_Chunck := "RIFF";
      Wave_File.Header.WAVE_Format := "WAVE";
      Wave_File.Header.Subchunk1_ID := "fmt ";
      Wave_File.Header.Subchunk2ID := "data";
      Wave_File.Header.Chunk_Size :=  36;
      Wave_File.Header.SubChunk1Size :=  1;
      Wave_File.Header.AudioFormat  :=  1;
      Wave_File.Header.NumChannels :=  1;
      Wave_File.Header.SampleRate :=  11025;
      Wave_File.Header.ByteRate :=  22050;
      Wave_File.Header.BlockAlign :=  2;
      Wave_File.Header.BitsPerSample :=  16;
      Wave_File.Header.SubChunk2Size :=  80000;
   end Init_Header;


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Update_Header(Wave_File : in out Wave_File_T;
                           Sample_Rate : Unsigned_32;
                           Channel_Numbers : Unsigned_16;
                           Data_Length : Unsigned_32) is

   begin
      Wave_File.Header.Chunk_Size := 36 + Data_Length;
      Wave_File.Header.SubChunk1Size := 16;
      Wave_File.Header.AudioFormat  := 1;
      Wave_File.Header.NumChannels := Channel_Numbers;
      Wave_File.Header.SampleRate := Sample_Rate;
      Wave_File.Header.ByteRate := Wave_File.Header.SampleRate * Unsigned_32(Wave_File.Header.BitsPerSample/8);
      Wave_File.Header.BlockAlign := 2;
      Wave_File.Header.BitsPerSample := 16;
      Wave_File.Header.SubChunk2Size := Data_Length;
   end Update_Header;

   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Dump_Wave_Data(Wave_File : in Wave_File_T) is

   begin
      for I in 1 .. Wave_File.Data'Length loop
         Put_Line(Integer'Image(I) & " " & Data_Type'Image(Wave_File.Data(I)));
      end loop;
   end Dump_Wave_Data;


   ----------------------------------------------------------------------
   --
   --
   --
   ----------------------------------------------------------------------
   procedure Test is
         Wave_File : Wave_File_T;

   begin
      Load("./lyd/WaveTest2.wav", Wave_File);
      Wave_Info(Wave_File);
--      Wave_Header.NumChannels := 2;
      Save("./lyd/W1.wav", Wave_File);
   end Test;

end Wave_Io;
