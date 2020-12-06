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
		.map!(g => g
			.split("\n")
			.map!(l => l.array)
			.fold!((a, b) => a
				.filter!(c => b.empty || b.canFind(c)).array)
			.length)
		.fold!((a, b) => a + b);
	writeln(result);
}
