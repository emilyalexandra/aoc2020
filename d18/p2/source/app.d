import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.regex;
import std.stdio;
import std.string;

auto numPat = regex(`[0-9]+`);
auto opPat = regex(`(\*|\+)`);

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	lines.map!(l => l.solveLine)
		.fold!((a, b) => a + b)
		.writeln;
}

ulong solveLine(string line) {
	line = line.filter!(c => c != ' ').to!string;
	for (int i = 0; i < line.length; i++) {
		char c = line[i];
		if (c == '(') {
			int bal = 0;
			for (int j = i + 1; j < line.length; j++) {
				char d = line[j];
				if (d == '(') bal++;
				if (d == ')') {
					if (bal == 0) {
						ulong v = solveLine(line[i + 1..j]);
						line = line[0..i] ~ v.to!string ~ line[j + 1..$];
						break;
					}
					bal--;
				}
			}
		}
	}
	ulong[] ints;
	char[] ops;
	foreach (h; matchAll(line, numPat)) {
		ints ~= h.hit.to!ulong;
	}
	foreach (h; matchAll(line, opPat)) {
		ops ~= h.hit[0];
	}
	for (int i = 0; i < ops.length; i++) {
		if (ops[i] == '+') {
			ints[i] = ints[i] + ints[i + 1];
			ints = ints[0..i + 1] ~ ints[i + 2..$];
			ops = ops[0..i] ~ ops[i + 1..$];
			i--;
		}
	}
	return ints.fold!((a, b) => a * b);
}

unittest{
	assert(solveLine("1 + (2 * 3) + (4 * (5 + 6))") == 51);
	assert(solveLine("2 * 3 + (4 * 5)") == 46);
	assert(solveLine("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445);
	assert(solveLine("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 669060);
	assert(solveLine("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340);
}
