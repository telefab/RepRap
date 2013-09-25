BaseBorderSize      = 40;
BaseThickness       = 2;

ScrewHoleRadius     = 2;
ScrewHoleDistance   = 32;

ConeThickness       = 0.9;
ConeBaseRadius      = BaseBorderSize/2;
ConeTopRadius       = (BaseBorderSize/2)*1;
ConeHeight          = 35;


ConePlatPartAngle   = 23 ;
OpeningRatio        = 0.2;

LengthSupport       = BaseBorderSize/2;
WidthSupport        = 10;
ThichnessSupport    = 10;

$fn = 60;


module HeadFanMount()
{
    union()
    {
    
        difference() // BASE
        {
            cube([BaseBorderSize , BaseBorderSize , BaseThickness]);
            
            translate([(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , -0.5])
            {
                cylinder(h = BaseThickness + 1 , r = ScrewHoleRadius);
            }
            
            translate([BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , -0.5])
            {
                cylinder(h = BaseThickness + 1 , r = ScrewHoleRadius);
            }
            
            translate([(BaseBorderSize-ScrewHoleDistance)/2 , BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , -0.5])
            {
                cylinder(h = BaseThickness + 1 , r = ScrewHoleRadius);
            }
            
            translate([BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , -0.5])
            {
                cylinder(h = BaseThickness + 1 , r = ScrewHoleRadius);
            }
            
            translate([BaseBorderSize/2 , BaseBorderSize/2 , -0.5])
            {
                cylinder(h = BaseThickness + 1 , r = ConeBaseRadius-ConeThickness);
            }
            
            difference()
            {
                translate([0 , 0 , -0.5])
                {
                    cube([(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , BaseThickness + 1]);
                }
                translate([(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , -1])
                {
                    cylinder(h = BaseThickness + 2 , r = (BaseBorderSize-ScrewHoleDistance)/2);
                }
            }
            difference()
            {
                translate([BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , 0 , -0.5])
                {
                    cube([(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , BaseThickness + 1]);
                }
                translate([BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , -1])
                {
                    cylinder(h = BaseThickness + 2 , r = (BaseBorderSize-ScrewHoleDistance)/2);
                }
            }
            difference()
            {
                translate([0 , BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , -0.5])
                {
                    cube([(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , BaseThickness + 1]);
                }
                translate([(BaseBorderSize-ScrewHoleDistance)/2 , BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , -1])
                {
                    cylinder(h = BaseThickness + 2 , r = (BaseBorderSize-ScrewHoleDistance)/2);
                }
            }
            difference()
            {
                translate([BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , -0.5])
                {
                    cube([(BaseBorderSize-ScrewHoleDistance)/2 , (BaseBorderSize-ScrewHoleDistance)/2 , BaseThickness + 1]);
                }
                translate([BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , BaseBorderSize-(BaseBorderSize-ScrewHoleDistance)/2 , -1])
                {
                    cylinder(h = BaseThickness + 2 , r = (BaseBorderSize-ScrewHoleDistance)/2);
                }
            }
        }
        
        
        
        
        difference()    // Cone
        {
            translate([BaseBorderSize/2 , BaseBorderSize/2 , BaseThickness])
            {
                cylinder(h = ConeHeight , r1 = ConeBaseRadius , r2 = ConeTopRadius);
            }
            translate([BaseBorderSize/2 , BaseBorderSize/2 , BaseThickness-0.1])
            {
                cylinder(h = ConeHeight+0.2 , r1 = ConeBaseRadius-ConeThickness , r2 = ConeTopRadius-ConeThickness);
            }
            translate([(BaseBorderSize/2-ConeTopRadius+ConeThickness)+(ConeHeight+BaseThickness)*tan(ConePlatPartAngle)+(ConeTopRadius/2-ConeThickness)*2*OpeningRatio+ConeTopRadius , -10 , 0])
            {
                rotate([0 , -ConePlatPartAngle , 0])
                {
                    cube([ConeHeight , BaseBorderSize+20 , (ConeHeight)/cos(ConePlatPartAngle)*2]);
                }
            }
            translate([BaseBorderSize , 0 , 0])
            {
                mirror([1 , 0 , 0])
                {
                    translate([(BaseBorderSize/2-ConeTopRadius+ConeThickness)+(ConeHeight+BaseThickness)*tan(ConePlatPartAngle)+(ConeTopRadius/2-ConeThickness)*2*OpeningRatio+ConeTopRadius , -10 , 0])
                    {
                        rotate([0 , -ConePlatPartAngle , 0])
                        {
                            cube([ConeHeight , BaseBorderSize+20 , (ConeHeight)/cos(ConePlatPartAngle)*2]);
                        }
                    }
                }
            }
        }
        
        difference()
        {
            union()
            {
                translate([(BaseBorderSize/2-ConeTopRadius+ConeThickness)+(ConeHeight+BaseThickness)*tan(ConePlatPartAngle)+(ConeTopRadius/2-ConeThickness)*2*OpeningRatio+ConeTopRadius , -10 , 0])
                {
                    rotate([0 , -ConePlatPartAngle , 0])
                    {
                        cube([ConeThickness , BaseBorderSize+20 , (ConeHeight)/cos(ConePlatPartAngle)*2]);
                    }
                }
                translate([BaseBorderSize , 0 , 0])
                {
                    mirror([1 , 0 , 0])
                    {
                        translate([(BaseBorderSize/2-ConeTopRadius+ConeThickness)+(ConeHeight+BaseThickness)*tan(ConePlatPartAngle)+(ConeTopRadius/2-ConeThickness)*2*OpeningRatio+ConeTopRadius , -10 , 0])
                        {
                            rotate([0 , -ConePlatPartAngle , 0])
                            {
                                cube([ConeThickness , BaseBorderSize+20 , (ConeHeight)/cos(ConePlatPartAngle)*2]);
                            }
                        }
                    }
                }
            }
            difference()
            {
                translate([-(ConeHeight)/cos(ConePlatPartAngle) , -BaseBorderSize/2 , -ConeHeight/2])
                {
                    cube([(ConeHeight)/cos(ConePlatPartAngle)*3 , BaseBorderSize*2 , ConeHeight*3]);
                }
                translate([BaseBorderSize/2 , BaseBorderSize/2 , BaseThickness])
                {
                    cylinder(h = ConeHeight , r1 = ConeBaseRadius , r2 = ConeTopRadius);
                }
            }
        }
        
        difference()
        {
            translate([-WidthSupport+4 , (BaseBorderSize-LengthSupport)/2 , 0])
            {
                // cube([WidthSupport+4 , LengthSupport , ThichnessSupport]);
            }
            translate([BaseBorderSize/2 , BaseBorderSize/2 , BaseThickness-0.1])
            {
                // cylinder(h = ConeHeight+0.2 , r1 = ConeBaseRadius-ConeThickness , r2 = ConeTopRadius-ConeThickness);
            }
            translate([BaseBorderSize/2 , BaseBorderSize/2 , -0.5])
            {
                // cylinder(h = BaseThickness + 1 , r = ConeBaseRadius-ConeThickness);
            }
        }
        
        translate([0 , BaseBorderSize/2 , ConeHeight+BaseThickness ])
        {
            rotate([0 , 90 , 0])
            {
                // cylinder(h = ConeTopRadius*2+1 , r = ConeTopRadius);
            }
        }
        
        translate([BaseBorderSize/2-(ConeTopRadius/2-ConeThickness)*2*OpeningRatio-ConeThickness-ConeThickness, 0 , ConeHeight+BaseThickness ])
        {
            cube([ConeThickness , BaseBorderSize , ConeHeight]);
        }

        translate([BaseBorderSize/2+(ConeTopRadius/2-ConeThickness)*2*OpeningRatio+ConeThickness , 0 , ConeHeight+BaseThickness ])
        {
            cube([ConeThickness , BaseBorderSize , ConeHeight]);
        }




     
    }


    
    // echo("BaseBorderSize/2-ConeTopRadius" , BaseBorderSize/2-ConeTopRadius);
    // echo("(BaseBorderSize/2-ConeTopRadius)*2+ConeTopRadius*2" , (BaseBorderSize/2-ConeTopRadius)*2+ConeTopRadius*2);
    
    
    
    
}

HeadFanMount();