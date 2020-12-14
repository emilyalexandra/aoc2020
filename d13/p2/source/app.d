import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

struct Pair {
	ulong id;
	ulong offset;
}

// This might work if you run it long enough
void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	string[] ids = lines[1].split(",");
	int largest = 0;
	int offset;
	Pair[] pairs;
	for (int i = 0; i < ids.length; i++) {
		if (ids[i] == "x") continue;
		int id = ids[i].to!int;
		if (id > largest) {
			largest = id;
			offset = i;
		}
		pairs ~= Pair(id, i);
	}
	pairs = pairs.sort!((a, b) => a.id > b.id).array;
	writeln(pairs);
	writeln(largest);
	writeln(offset);
	outer:
	for (ulong t = largest - offset; ; t += largest) {
		for (uint i = 0; i < pairs.length; i++) {
			Pair p = pairs[i];
			if ((t + p.offset) % p.id != 0) continue outer;
		}
		writeln(t);
		break;
	}
}