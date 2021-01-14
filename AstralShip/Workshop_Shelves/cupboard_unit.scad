// Shelf door wheel mount
// John Bargman - 2021
// Astral Ship Engineering

//Import shelf door mounting
use<shelf_door_wheel_mount.scad>

/* [Material Parameters] */
// Width of sheet board material
Sheet_Material_Width = 9;
//maximum length of a single board
Sheet_Material_Max_Width = 1220;
//maximum width of a single board
Sheet_Material_Max_Length = 2440;

/* [Cupboard Settings] */
//length of entire cupbard unit
Cupboard_Total_Length = 5500;
//height of the top surface of the unit
Cupboard_Total_Height = 1100;
//width of the entire unit (at most distant point)
Cupboard_Total_Width = 330;


/* [Core Parameters] */
//Width of bearings in wheel housing
Bearing_Width = 14;
//width of roller bracket
Bracket_Width = 50;
// Bracket backwall width in milimeters
Bracket_Wall = 4;
//Number of milimeters per door_roller
Roller_Spacing = 500;
// Fitting distance from roller-base (the distance from the sheet to the base of the roller's trough)
Fitting_Distance = 5;
//tolerance on slide_fittings
tolerance = 1;

/* [Roller Cut Position] */
//difference between two bearing-fixing
Bearing_Position = Bearing_Width + Sheet_Material_Width + Bracket_Wall + 5;
// milimeter difference between the two tracks of front and rear doors
Bearing_Roller_Diff = (Bearing_Position*2) - (Bracket_Wall*2);

//Roller-trough Width
Roller_trough_Width = 101.6;
Roller_trough_Height = 50;

module Cupboard_Door(Width, Height)
{
  //Draw sheet material in red
  translate([0,-Sheet_Material_Width,0])
  color([0.5,0.3,0.3,1])
    cube([Width, Sheet_Material_Width,Height]);

  translate([Bracket_Width / 2 ,0,0])
    door_wheel_assembly();
  translate([Bracket_Width / 2 ,0,Height]) rotate([0,180,0])
    door_wheel_assembly();

  for(i = [Roller_Spacing:Roller_Spacing:Width])
  {
    translate([(-Bracket_Width / 2) + i,0,0])
    {
      door_wheel_assembly();
      translate([0,0,Height]) rotate([0,180,0])
        door_wheel_assembly();
    }
  }

}

module Workshop_Cabinate()
{
  //Draw Frame

  //Draw Sheets

  //draw door runners
  difference()
  {
    translate([tolerance ,-(Roller_trough_Width / 2) - 15 , -(Roller_trough_Height + Fitting_Distance + tolerance)])
      cube([Cupboard_Total_Length, Roller_trough_Width, Roller_trough_Height ]);
    union()
    {
    translate([tolerance ,Bracket_Wall ,-Bracket_Wall - Fitting_Distance - (tolerance * 3)])
      cube([Cupboard_Total_Length,Bearing_Width + (tolerance * 2),Fitting_Distance + (tolerance*2)]);
    translate([tolerance ,Bracket_Wall - Bearing_Roller_Diff,-Bracket_Wall - Fitting_Distance - (tolerance * 3)])
      cube([Cupboard_Total_Length, Bearing_Width + (tolerance * 2),Fitting_Distance + (tolerance*2)]);
    }
  }
  //Draw Doors

  Divider_Rate = Cupboard_Total_Length / Sheet_Material_Max_Width;
  for( i = [0:1:Divider_Rate])
  {
    translate([Sheet_Material_Max_Width * i,0,0])
    {
      if(i % 2 == 0)
        Cupboard_Door(Sheet_Material_Max_Width,Cupboard_Total_Height);
      else
      rotate([0,0,180])
        translate([-Sheet_Material_Max_Width, Bearing_Position ,0])
        Cupboard_Door(Sheet_Material_Max_Width,Cupboard_Total_Height);
    }
  }
}



Workshop_Cabinate();
