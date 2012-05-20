EXE = wave_io_test
ADA_VERSION = -gnat05

SRC = Wave_Io.adb \
      Wave_Tools.adb \
      High_Pass_Filter.adb \
      Volume_Filter.adb \
      Distortion_Effect.adb \
      Delay_Effect.adb \
      Sine_Wave.adb \
      Square_Wave.adb \
      Sawtooth_Wave.adb \
      Triangle_Wave.adb \
      White_Noise.adb \
      Test_Package.adb \
      Wave_Io_Test.adb

FLAGS = -gnato -gnatwa -fstack-check

all: 
	gnatmake $(ADA_VERSION) $(FLAGS) $(SRC)

ada83: 
	gnatmake -gnat83  $(FLAGS) $(SRC)

ada95: 
	gnatmake -gnat95  $(FLAGS) $(SRC)

ada2005: 
	gnatmake -gnat05  $(FLAGS) $(SRC)

ada2012: 
	gnatmake -gnat12  $(FLAGS) $(SRC)

clean:
	rm *.ali *~ *.o $(EXE)