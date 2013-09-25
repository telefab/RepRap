HorizontalSpace                     = 30                                ; // Space between fixation holes
VerticalSpace                       = 50                                ; // Space between fixation holes
HorizontalSize                      = 97                                ;
VerticalSize                        = 100                               ;
Thickness                           = 40                                ;
BorderThickness                     = 3                                 ;
FixationHoleNutRaduis               = 8                                 ;
FixationHoleRaduis                  = 4.5                               ;
HoleCenterFromBorder                = 6+FixationHoleRaduis              ;
PlugHorizontalSize                  = 29                                ;
PlugVerticalSize                    = 60                                ;
HorizontalPlugPlacement             = 12                                ;
VerticalPlugPlacement               = VerticalSize-PlugVerticalSize-12  ;
EmptyPartHorizontalSize             = HorizontalSize - 52               ;
EmptyPartVerticalSize               = VerticalSize                      ;
horizontalDistanceBetweenPlugScrew  = 40                                ;
PlugScrewHoleRaduis                 = 1.8                               ;
PlugScrewHoleDepth                  = 17                                ;
PlugNutHoleWidth                    = 7                                 ;
PlugNutHoleHeight                   = 3.7                               ;
chamferRadius                       = 25                                ;
BottomThickness                     = 3                                 ;
WireHoleHorizontalPlacement         = 15                                ;
WireHoleVerticalPlacement           = 47                                ;
WireHoleRaduis                      = 6                                 ;
chamferAngle                        = 45                                ;
EdgeThickness                       = 3                                 ;
ChamferCubeLength                   = 100                               ;
ChamferCubeWidth                    = 40*cos(chamferAngle)*2            ;
ChamferCubeThickness                = 30                                ;

$fn                                 = 40                                ;

module PlugSupport()
{

	difference()
    {
        /*************************************************************************************************************
        ** GLOBAL VOLUME
        *************************************************************************************************************/
        cube([HorizontalSize , VerticalSize, Thickness]); //global volume

        /*************************************************************************************************************
        ** FIXATION HOLE
        *************************************************************************************************************/
		// above fixation hole
        translate([HorizontalSize-HoleCenterFromBorder,VerticalSpace+HoleCenterFromBorder,-0.5])
		{
            cylinder(h = Thickness+1 , r = FixationHoleRaduis);
		}

        // below fixation hole
		translate([HorizontalSize-HoleCenterFromBorder-HorizontalSpace,HoleCenterFromBorder,-0.5])
		{
            cylinder(h = Thickness+1 , r = FixationHoleRaduis);
		}

        /*************************************************************************************************************
        ** THIN PART
        *************************************************************************************************************/
        //thin part cube removal
        translate([HorizontalSize-EmptyPartHorizontalSize,-0.5,BorderThickness])
		{
            cube([EmptyPartHorizontalSize+1, EmptyPartVerticalSize+1, Thickness-BorderThickness+1]);
		}
        
        /*************************************************************************************************************
        ** PLUG HOLE
        *************************************************************************************************************/
        // plug hole
        translate([HorizontalPlugPlacement,VerticalPlugPlacement,-0.5])
		{
            cube([PlugHorizontalSize , PlugVerticalSize, Thickness+2]);
		}
		
        // left plug fixation hole
		translate([HorizontalPlugPlacement-(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2,VerticalPlugPlacement+PlugVerticalSize/2,-0.5])
		{
            cylinder(h = Thickness+1 , r = PlugScrewHoleRaduis);
		}
        
        // right plug fixation hole
		translate([HorizontalPlugPlacement+PlugHorizontalSize+(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2,VerticalPlugPlacement+PlugVerticalSize/2,-0.5])
		{
            cylinder(h = Thickness+1 , r = PlugScrewHoleRaduis);
		}
        
        // Plug fixation Nut Hole 
        translate([HorizontalPlugPlacement-(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2-PlugNutHoleWidth/2-9.8,VerticalPlugPlacement+PlugVerticalSize/2-PlugNutHoleWidth/2,Thickness-15]) //bottom left
        {   
            cube([PlugNutHoleWidth+10.2 , PlugNutHoleWidth, PlugNutHoleHeight]);
        }
        
        translate([HorizontalPlugPlacement-(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2-PlugNutHoleWidth/2-9.8,VerticalPlugPlacement+PlugVerticalSize/2-PlugNutHoleWidth/2,9]) //bottom left
        {   
            cube([PlugNutHoleWidth+10.2 , PlugNutHoleWidth, PlugNutHoleHeight]);
        }
        
        translate([HorizontalPlugPlacement+PlugHorizontalSize+(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2-PlugNutHoleWidth/2-0.2,VerticalPlugPlacement+PlugVerticalSize/2-PlugNutHoleWidth/2,Thickness-15]) //bottom left
        {   
            cube([PlugNutHoleWidth+10.2 , PlugNutHoleWidth, PlugNutHoleHeight]);
        }
        
        translate([HorizontalPlugPlacement+PlugHorizontalSize+(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2-PlugNutHoleWidth/2-0.2,VerticalPlugPlacement+PlugVerticalSize/2-PlugNutHoleWidth/2,9]) //bottom left
        {   
            cube([PlugNutHoleWidth+10.2 , PlugNutHoleWidth, PlugNutHoleHeight]);
        }

        /*************************************************************************************************************
        ** CIRCULAR CHAMFER 
        *************************************************************************************************************/
        //chamfers top right
        translate([HorizontalSize - chamferRadius , VerticalSize - chamferRadius , -0.5])
        {   
            difference()
            {
                cube([chamferRadius+0.1 , chamferRadius+0.1, Thickness+2]);
                cylinder(h = Thickness+1 , r = chamferRadius);
            }
        }

        //chamfers bottom left plug hole
        difference()
        {
            translate([-0.1 , -0.1 , -0.5])
            cube([chamferRadius+0.1 , chamferRadius+0.1, Thickness+10]);
            translate([chamferRadius , chamferRadius , -0.5])
            {   
                cylinder(h = Thickness+10 , r = chamferRadius);
            }
        }
        
        //chamfers bottom right plug hole
        translate([HorizontalSize-EmptyPartHorizontalSize-chamferRadius , -0.1 , BorderThickness])
        {
            difference()
            {
                cube([chamferRadius+0.1 , chamferRadius+0.1, Thickness+10]);
                translate([0 , chamferRadius , -0.5])
                {   
                    cylinder(h = Thickness+12 , r = chamferRadius);
                }
            }
        }
        /*************************************************************************************************************
        ** TOP BOTTOM FIXATION 
        *************************************************************************************************************/
        // Top Bottom fixation screw holes
        translate([chamferRadius/2 , chamferRadius/2 , -0.5]) //bottom left
        {   
            cylinder(h = PlugScrewHoleDepth+0.5 , r = PlugScrewHoleRaduis);
        }
        
        translate([chamferRadius/3 , VerticalSize - chamferRadius/3 , -0.5]) //top left
        {   
            cylinder(h = PlugScrewHoleDepth+0.5 , r = PlugScrewHoleRaduis);
        }
        
        translate([HorizontalSize - chamferRadius/3 , chamferRadius/3 , -0.5]) //bottom right
        {   
            cylinder(h = Thickness+10 , r = PlugScrewHoleRaduis);
        }
        
        translate([HorizontalSize - chamferRadius/2 , VerticalSize - chamferRadius/2 , -0.5])//top right
        {   
            cylinder(h = Thickness+10 , r = PlugScrewHoleRaduis);
        }
        
        // Top Bottom fixation nut holes
        translate([chamferRadius/2-PlugNutHoleWidth/2 , chamferRadius/2-PlugNutHoleWidth/2-10 , 9]) //bottom left
        {   
            cube([PlugNutHoleWidth , PlugNutHoleWidth+10.2, PlugNutHoleHeight]);
        }
        
        translate([chamferRadius/3-PlugNutHoleWidth/2.2-10.2 , VerticalSize - chamferRadius/3-PlugNutHoleWidth/2 , 9]) //top left
        {   
            cube([PlugNutHoleWidth+10.2 , PlugNutHoleWidth, PlugNutHoleHeight]);
        }

        /*************************************************************************************************************
        ** CHAMFER
        *************************************************************************************************************/
        translate([-5 , (VerticalPlugPlacement-EdgeThickness) - Thickness , 0])
        {
            rotate([chamferAngle , 0 , 0])
            {
                cube([ChamferCubeLength , ChamferCubeWidth, ChamferCubeThickness]);
            }
        }

        translate([-5 , VerticalSize+ChamferCubeThickness*cos(chamferAngle)+(VerticalPlugPlacement+EdgeThickness) , ChamferCubeThickness*cos(chamferAngle)])
        {
            rotate([90+chamferAngle , 0 , 0])
            {
                cube([ChamferCubeLength , ChamferCubeWidth, ChamferCubeThickness]);
            }
        }
        
        translate([PlugHorizontalSize+HorizontalPlugPlacement-50 , PlugVerticalSize+VerticalPlugPlacement+50+11+EdgeThickness , BorderThickness])
        {
            rotate([0 , 0 , -45])
            {
                cube([ChamferCubeLength , ChamferCubeThickness , ChamferCubeWidth]);
            }
        }
        
        /*************************************************************************************************************
        ** PLUG SHAPE CHAMFER
        *************************************************************************************************************/
        translate([52-12 , VerticalSize , Thickness+ChamferCubeThickness*cos(chamferAngle)])
        {
            rotate([-45 , 0 , 90+atan(11/32.5)])
            {
                cube([ChamferCubeLength , ChamferCubeThickness , ChamferCubeWidth], center = true);
            }
        }
        
        translate([12-ChamferCubeThickness*cos(chamferAngle) , 100 , Thickness])
        {
            rotate([-45 , 0 , -90-atan(11/32.5)])
            {
                cube([ChamferCubeLength , ChamferCubeThickness , ChamferCubeWidth], center = true);
            }
        }
        
        translate([12+ChamferCubeThickness*cos(chamferAngle)-ChamferCubeThickness*2*cos(chamferAngle) , VerticalPlugPlacement-12 , Thickness])
        {
            rotate([45 , 0 , 90+atan(11/32.5)])
            {
                cube([ChamferCubeLength , ChamferCubeThickness , ChamferCubeWidth], center = true);
            }
        }
        
        translate([52-12 ,  VerticalPlugPlacement-12 , Thickness+ChamferCubeThickness*cos(chamferAngle)])
        {
            rotate([45 , 0 , -90-atan(11/32.5)])
            {
                cube([ChamferCubeLength , ChamferCubeThickness , ChamferCubeWidth+5], center = true);
            }
        }
	}
}





module Bottom()
{
	difference() {
    
		cube([HorizontalSize , VerticalSize, BottomThickness]); //global volume
		
		// above fixation hole
        translate([HorizontalSize-HoleCenterFromBorder,VerticalSpace+HoleCenterFromBorder,-0.5])
		{
            cylinder(h = Thickness+1 , r = FixationHoleRaduis);
		}
        
        // below fixation hole
		translate([HorizontalSize-HoleCenterFromBorder-HorizontalSpace,HoleCenterFromBorder,-0.5])
		{
            cylinder(h = Thickness+1 , r = FixationHoleRaduis);
		}
        
        // Wire Hole
        translate([HorizontalPlugPlacement+WireHoleHorizontalPlacement,VerticalPlugPlacement+WireHoleVerticalPlacement,-0.5])
		{
            cylinder(h = Thickness+1 , r = WireHoleRaduis);
		}
		
        // left plug fixation hole
		translate([HorizontalPlugPlacement-(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2,VerticalPlugPlacement+PlugVerticalSize/2,-0.5])
		{
            cylinder(h = Thickness+1 , r = PlugScrewHoleRaduis);
		}
        
        // right plug fixation hole
		translate([HorizontalPlugPlacement+PlugHorizontalSize+(horizontalDistanceBetweenPlugScrew-PlugHorizontalSize)/2,VerticalPlugPlacement+PlugVerticalSize/2,-0.5])
		{
            cylinder(h = Thickness+1 , r = PlugScrewHoleRaduis);
		}
        
        //chamfer
        translate([HorizontalSize - chamferRadius , VerticalSize - chamferRadius , -0.5])
        {   
            difference()
            {
                cube([chamferRadius+0.1 , chamferRadius+0.1, Thickness+2]);
                cylinder(h = Thickness+1 , r = chamferRadius);
            }
        }

        difference()
        {
            translate([-0.1 , -0.1 , -0.5])
            cube([chamferRadius+0.1 , chamferRadius+0.1, Thickness+10]);
            translate([chamferRadius , chamferRadius , -0.5])
            {   
                cylinder(h = Thickness+10 , r = chamferRadius);
            }
        }
        // Top/Bottom fixation
        translate([chamferRadius/2 , chamferRadius/2 , -0.5]) //bottom left
        {   
            cylinder(h = Thickness+10 , r = PlugScrewHoleRaduis);
        }
        
        translate([chamferRadius/3 , VerticalSize - chamferRadius/3 , -0.5]) //top left
        {   
            cylinder(h = Thickness+10 , r = PlugScrewHoleRaduis);
        }
        
        translate([HorizontalSize - chamferRadius/3 , chamferRadius/3 , -0.5]) //bottom right
        {   
            cylinder(h = Thickness+10 , r = PlugScrewHoleRaduis);
        }
        
        translate([HorizontalSize - chamferRadius/2 , VerticalSize - chamferRadius/2 , -0.5])//top right
        {   
            cylinder(h = Thickness+10 , r = PlugScrewHoleRaduis);
        }
	}
}

translate([0 , 0 , -10])
{
    Bottom();
}

PlugSupport();

