ExternalLength              = 120                           ;
InternalMinimumHeight       = 45                            ;
Width                       = 59                            ;
FixationHoleRadius          = 4.5                           ;
SupportLength               = Width+2*FixationHoleRadius    ;
SupportWidth                = 15                            ;
SupportThickness            = 17                            ;
SupportHeight               = 75                            ;
HandleHoleRadius            = 9                             ;
VerticalSupportThickness    = 12                            ;
ScrewHoleRadius             = 2                             ;
BlockingSize                = 1                             ;


W   = Width                             ;
R   = FixationHoleRadius                ;
HR  = SupportThickness                  ;
HH  = SupportHeight-SupportThickness    ;
ADJ = W/2-R-HR                          ;
A   = atan(ADJ/HH)                      ;
HYP = HH/cos(A)                         ;

/*
Module support. This module is used to fixe the handle to the reprap. Two support modules are used, one on each side of the handle.
*/
module Support()
{

    union()
    {
        difference()    // BASE, cube that is attached to the reprap
        {
            union()
            {
                cube([SupportLength , SupportWidth , SupportThickness]);
                translate([0 , SupportWidth , SupportThickness/2])
                {
                    rotate([90 , 0 , 0])
                    {
                        cylinder(h = SupportWidth , r = SupportThickness/2);
                    }
                }
                translate([SupportLength , SupportWidth , SupportThickness/2])
                {
                    rotate([90 , 0 , 0])
                    {
                        cylinder(h = SupportWidth , r = SupportThickness/2);
                    }
                }
            }
            translate([(SupportLength-Width)/2-0.001 , SupportWidth*2 , SupportThickness-FixationHoleRadius])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = SupportWidth*3 , r = FixationHoleRadius);
                }
            }
            translate([SupportLength-(SupportLength-Width)/2+0.001 , SupportWidth*2 , SupportThickness-FixationHoleRadius])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = SupportWidth*3 , r = FixationHoleRadius);
                }
            }
            translate([(SupportLength-Width)/2-FixationHoleRadius+BlockingSize , -SupportWidth , SupportThickness-FixationHoleRadius])
            {
                cube([FixationHoleRadius*2-BlockingSize , SupportWidth*3 , SupportThickness]);
            }
            translate([SupportLength-(SupportLength-Width)/2-FixationHoleRadius , -SupportWidth , SupportThickness-FixationHoleRadius])
            {
                cube([FixationHoleRadius*2-BlockingSize , SupportWidth*3 , SupportThickness]);
            }
        }
        difference()    //SUPPORT, that hold the handle
        {
            union()
            {
                translate([FixationHoleRadius+(SupportLength-Width)/2 , 0 , SupportThickness])
                {
                    rotate([0 , A , 0])
                    cube([VerticalSupportThickness , SupportWidth , HYP]);
                }
                translate([Width-FixationHoleRadius-VerticalSupportThickness*cos(A)+(SupportLength-Width)/2 , 0 , SupportThickness-VerticalSupportThickness*sin(A)])
                {
                    rotate([0 , -A , 0])
                    cube([VerticalSupportThickness , SupportWidth , HYP]);
                }
                translate([SupportLength/2 , SupportWidth , SupportHeight])
                {
                    rotate([90 , 0 , 0])
                    {
                        cylinder(h = SupportWidth , r = SupportThickness);
                    }
                }
            }
            translate([SupportLength/2 , SupportWidth+1 , SupportHeight])
            {
                rotate([90 , 0 , 0])
                {
                    cylinder(h = SupportWidth+2 , r = HandleHoleRadius);
                }
            }
            translate([SupportLength/2 , SupportWidth/2 , SupportHeight])
            {
                rotate([90 , 0 , 90])
                {
                    cylinder(h = SupportThickness*3 , r = ScrewHoleRadius , center = true);
                }
            }
        }
    }
}


/*
Module Handle, build on two concentric half cylinder. The thin cylinder is used for the assembly, the thick one is used by the hand of the user
*/
module Handle()
{
    difference()
    {
        union()
        {
            rotate([-90 , 0 , 0])   // center
            {
                cylinder(h = ExternalLength , r = HandleHoleRadius);
            }
            translate([0 , SupportWidth , 0]) // Handle
            {
                rotate([-90 , 0 , 0])
                {
                    cylinder(h = ExternalLength-2*SupportWidth , r = SupportThickness-4);
                }
            }
        }
        translate([-0.5-SupportThickness , -0.5 , -SupportThickness])   // half part removal
        {
            cube([SupportThickness*2 , ExternalLength+1 , SupportThickness]);
        }
        translate([0 , SupportWidth/2 , -0.5])  // srew hole
        {
            cylinder(h = SupportThickness , r = ScrewHoleRadius);
        }
        translate([0 , ExternalLength-SupportWidth/2 , -0.5])   // srew hole
        {
            cylinder(h = SupportThickness , r = ScrewHoleRadius);
        }
    }
}


module PrintView()
{
    rotate([90 , 0 , 0])
    {
        Support();
    }
    // Handle();
}

module SplitView()
{
    Support();
    translate([0 , ExternalLength-SupportWidth+50 , 0])
    {
        Support();
    }
    translate([SupportLength/2+10 , 25 , SupportHeight])
    {
        rotate([0 , 90 , 0])
        {
            Handle();
        }
    }
    translate([SupportLength/2-10 , 25 , SupportHeight])
    {
        rotate([0 , -90 , 0])
        {
            Handle();
        }
    }
}

module AssemblyView()
{
    Support();
    translate([0 , ExternalLength-SupportWidth , 0])
    {
        Support();
    }
    translate([SupportLength/2 , 0 , SupportHeight])
    {
        rotate([0 , 90 , 0])
        {
            Handle();
        }
    }
    translate([SupportLength/2 , 0 , SupportHeight])
    {
        rotate([0 , -90 , 0])
        {
            Handle();
        }
    }
}

// AssemblyView();
SplitView();
// PrintView();


81656721
950223

