module app;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	string[] passes = input.split("\n")[0..$ - 1];
	int[] ids = passes
		.map!(p => p
			.map!(c => (c & 4) == 0 ? '1' : '0')
			.to!int(2)).array
		.sort.array;
	int last = ids[0];
	for (int i = 1; i < ids.length; i++) {
		if (ids[i] - last != 1) {
			writeln(ids[i] - 1);
			break;
		}
		last = ids[i];
	}
}
