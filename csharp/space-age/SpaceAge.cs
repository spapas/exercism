using System;
using System.Collections.Generic;

public class SpaceAge
{
    const double EARTH_SECONDS = 31557600.0;
    static Dictionary<string, double> ORBIT_RATIOS = new Dictionary<string, double>() {
       {"earth", 1.0},
       {"mercury",  0.2408467},
       {"venus",   0.61519726},
       {"mars",   1.8808158},
       {"jupyter",   11.862615},
       {"saturn",   29.447498},
       {"uranus",   84.016846},
       {"neptune",   164.79132}
    };

    private int seconds;
    public SpaceAge(int seconds)
    {
        this.seconds = seconds ;
    }

    public double OnEarth() => this.seconds / EARTH_SECONDS; 
    public double OnMercury() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["mercury"];
    public double OnVenus() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["venus"];
    public double OnMars() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["mars"];
    public double OnJupiter() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["jupyter"];
    public double OnSaturn() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["saturn"];
    public double OnUranus() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["uranus"];
    public double OnNeptune() => this.seconds / EARTH_SECONDS / ORBIT_RATIOS["neptune"];

}
