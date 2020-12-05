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
	writeln(ids[$ - 1]);
}
