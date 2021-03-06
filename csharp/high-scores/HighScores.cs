using System;
using System.Collections.Generic;
using System.Linq;

public class HighScores
{
    private List<int> list;
    public HighScores(List<int> list)
    {
        this.list = list;
    }

    public List<int> Scores() => this.list;
    
    public int Latest() => this.list.Last();
    
    public int PersonalBest() => this.list.Max();
    
    public List<int> PersonalTopThree() => this.list.OrderByDescending(x=>x).Take(3).ToList();

}