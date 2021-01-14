// Shelf door wheel mount
// John Bargman - 2021
// Astral Ship Engineering

/* [ Bearing Details] */
// Diameter of the central-pivot of the Bearing-wheel used as a roller
Bearing_Inner_Diameter = 15;
// Bearing wheel outside Diameter - this is the edge that will roll on the ground
Bearing_Outer_Diameter = 43;
// Bearing wheel Width - this is the width along the rolling axis
Bearing_Width          = 14;
// This is the additional width added to allow the bearing clearence during rotation
Bearing_Clearing_Tolerance = 1;

/* [ Fitting Core Values] */
// Thickness of door sheet
Sheet_Material_Width = 9;
// Fitting distance from roller-base (the distance from the sheet to the base of the roller's trough)
Fitting_Distance = 5;
// The total width of the bracket
Bracket_Width = 50;
// The total height of the bracket
Bracket_Height = 40;
// Bracket backwall width in milimeters
Bracket_Wall = 4;
// Diameter of screws used to attach plate to sheet-Sheet_Material_Calc
Screw_diameter = 5;

/* [ Core parameters] */
// Origin Point of model (and bearing center-point)
origin = [0,Bearing_Width + Bracket_Wall + Bearing_Clearing_Tolerance, (Bracket_Height /2) - Bracket_Wall -Fitting_Distance ];
// Final object rotation
origin_rotation = [90,0,0];
// this is the general tolerance used for slip-fittings
tolerance = 0.1;




module door_bearing(paint_color=[0.8,0.5,0.5,1])
{
  translate(origin) rotate(origin_rotation)
  {
    color(paint_color)
    translate([0,0,Bearing_Width/2])
      scale([2,2,2])
          import("stl/608v2_0.stl");
  }
}
module door_wheel()
{
  clearence_wall = 50;
  Bearing_Calc_Width = Bearing_Width + Bearing_Clearing_Tolerance;
  Sheet_Material_Calc = Sheet_Material_Width + (tolerance * 2);
  Sheet_Width = Bracket_Width * 10;
  Sheet_Lift = -(Bracket_Height /2) + Bracket_Wall ;

  translate(origin) rotate(origin_rotation)
  {
    difference()
    {
      union()
      {
        translate([0,Fitting_Distance,0])
        {
          // Generate Bracket
          translate([-Bracket_Width/2, -Bracket_Height/2, tolerance])
          {
          cube([Bracket_Width,
            Bracket_Height,
            Bearing_Width + Bearing_Clearing_Tolerance + Bracket_Wall]);

          // Generate Bracket Rear
          translate([0, 0, Bearing_Calc_Width])
            cube([Bracket_Width,
              Bracket_Height,
              Sheet_Material_Calc + (Bracket_Wall * 2)]);
          }
        }
      }
      translate([0,Fitting_Distance,0])
      {
        //Generate Sheet-material cutout
        translate([-Sheet_Width/2, Sheet_Lift, Bearing_Calc_Width + Bracket_Wall])
        {
          cube([Sheet_Width ,Bracket_Height * 2 ,Sheet_Material_Calc]);
        }
      }
      union()
      { //Generate holes for wood-screw attatchment
        translate([Bracket_Width/2 - Bracket_Wall,Bracket_Height / 2 - Bracket_Wall,0])
        {
          cylinder(d = Screw_diameter, h=(Bearing_Calc_Width + Bracket_Wall) * 2);
        }
        translate([-Bracket_Width/2 + Bracket_Wall,Bracket_Height / 2 - Bracket_Wall,0])
        {
          cylinder(d = Screw_diameter, h=(Bearing_Calc_Width + Bracket_Wall) * 2);
        }

      }
      difference()
      { //Create dummy-Bearing using measured parameters
        cylinder(d=Bearing_Outer_Diameter + Bearing_Clearing_Tolerance,
          h=Bearing_Width + Bearing_Clearing_Tolerance);
        cylinder(d=Bearing_Inner_Diameter + tolerance,
          h=Bearing_Width + Bearing_Clearing_Tolerance + tolerance);
      }
    }
  }
}
module door_wheel_assembly()
{
  door_wheel();
  door_bearing();

}

door_wheel_assembly();
