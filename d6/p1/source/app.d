import std.algorithm;
import std.array;
import std.ascii: isWhite;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	int result = input
		.split("\n\n")
		.map!(l => l
			.filter!(c => !c.isWhite).array
			.sort
			.uniq.array
			.length)
		.fold!((a, b) => a + b);
	writeln(result);
}
