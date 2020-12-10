import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;

void main() {
	string input = cast(string) read("../input.txt");
	int[] arr = input.split("\n")[0..$ - 1].map!(l => l.to!int).array.sort.array;
	int oneDiffs = 0;
	int threeDiffs = 1;
	int cur = 0;
	foreach (int i; arr) {
		int diff = i - cur;
		if (diff == 1) oneDiffs++;
		else if (diff == 3) threeDiffs++;
		cur = i;
	}
	writeln(oneDiffs * threeDiffs);
}
