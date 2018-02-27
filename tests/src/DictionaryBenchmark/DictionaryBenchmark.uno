using Uno;
using Uno.Collections;
using Uno.Diagnostics;
using Uno.Text;

public class DictionaryBenchmark : Uno.Application
{
    void Add(int entries)
    {
        var random = new Random(1337);
        var entriesToAdd = new int[entries * 2];
        var keys = new HashSet<int>();
        for (int i = 0; i < entries; ++i)
        {
            int key;
            do
            {
                key = random.Next();
            }
            while (keys.Contains(key));
            keys.Add(key);

            var value = random.Next();

            entriesToAdd[i * 2 + 0] = key;
            entriesToAdd[i * 2 + 1] = value;
        }

        var dict = new Dictionary<int, int>();

        var startTick = Clock.GetSeconds();

        for (int i = 0; i < entries; ++i)
        {
            var key = entriesToAdd[i * 2 + 0];
            var value = entriesToAdd[i * 2 + 1];
            dict.Add(key, value);
        }

        var endTick = Clock.GetSeconds();
        Debug.Log("time: " + (endTick - startTick) * 1000 + " ms");
    }

    void Set(int entries)
    {
        var random = new Random(1337);
        var entriesToAdd = new int[entries * 2];
        for (int i = 0; i < entries * 2; ++i)
            entriesToAdd[i] = random.Next();

        var dict = new Dictionary<int, int>();

        var startTick = Clock.GetSeconds();

        for (int i = 0; i < entries; ++i)
        {
            var key = entriesToAdd[i * 2 + 0];
            var value = entriesToAdd[i * 2 + 1];
            dict[key] = value;
        }

        var endTick = Clock.GetSeconds();
        Debug.Log("time: " + (endTick - startTick) * 1000 + " ms");
    }

    void Replace(int entries)
    {
        var random = new Random(1337);
        var entriesToAdd = new int[entries * 2];
        for (int i = 0; i < entries * 2; ++i)
            entriesToAdd[i] = random.Next();

        var dict = new Dictionary<int, int>();
        for (int i = 0; i < entries; ++i)
        {
            var key = entriesToAdd[i * 2 + 0];
            dict[key] = 0;
        }

        var startTick = Clock.GetSeconds();

        for (int i = 0; i < entries; ++i)
        {
            var key = entriesToAdd[i * 2 + 0];
            var value = entriesToAdd[i * 2 + 1];
            dict[key] = value;
        }

        var endTick = Clock.GetSeconds();
        Debug.Log("time: " + (endTick - startTick) * 1000 + " ms");
    }

    public DictionaryBenchmark()
    {
        Debug.Log("Add:");
        Add(1000000);
        Debug.Log("");

        Debug.Log("Set:");
        Set(1000000);
        Debug.Log("");

        Debug.Log("Replace:");
        Replace(1000000);
        Debug.Log("");

        if defined(!MOBILE)
            Environment.Exit(0);
    }
}
