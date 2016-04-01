public enum Foo
{
	Foo = 0
}

public enum Bar
{
	Bar1 = 0,
	Bar2 = 1,
	Bar3 = 2
}

class Baz
{
	static public int Test(Foo b)
	{
		switch (b)
		{
			case Bar.Bar1: // $E2047
				return 1;
			case Bar.Bar2: // $E2047
				return 2;
			case Bar.Bar3: // $E2047
				return 3;
		}
	}
}
