import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	ulong[] ints = input.split("\n")[0..$ - 1].map!(l => l.to!ulong).array;
	uint i = 25;
	while (i < ints.length) {
		if (!valid(ints[i - 25..i], ints[i])) {
			writeln(ints[i]);
			break;
		}
		i++;
	}
}

bool valid (ulong[] prev, ulong goal) {
	for (uint i = 0; i < prev.length; i++) {
		for (uint j = i + 1; j < prev.length; j++) {
			if (prev[i] + prev[j] == goal) {
				return true;
			}
		}
	}
	return false;
}
