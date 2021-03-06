import std.conv;
import std.file;
import std.regex;
import std.stdio;
import std.string;

auto reg = regex("([0-9]+)-([0-9]+)\\s*([a-zA-Z]):\\s*([a-zA-Z]*)");

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n");
	int valid = 0;
	foreach (string line; lines) {
		if (line.length == 0) continue;
		if (isValidLine(line)) valid++;
	}
	writeln(valid);
}

bool isValidLine(string s) {
	auto r = matchFirst(s, reg);
	int low = r[1].to!int;
	int high = r[2].to!int;
	char letter = r[3][0];
	string pass = r[4];
	bool b = false;
	if (pass.length > low - 1 && pass[low - 1] == letter) b = !b;
	if (pass.length > high - 1 && pass[high - 1] == letter) b = !b;
	return b;
}

unittest {
	assert(isValidLine("1-3 a: abcde"));
	assert(!isValidLine("1-3 b: cdefg"));
	assert(!isValidLine("2-9 c: ccccccccc"));
}
