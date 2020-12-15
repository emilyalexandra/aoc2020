import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

ulong[ulong] mem;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	ulong andMask;
	ulong orMask;
	foreach (string line; lines) {
		if (line.startsWith("mask = ")) {
			line = line[7..$];
			andMask = line.replace('X', '1').to!ulong(2);
			orMask = line.replace('X', '0').to!ulong(2);
		} else {
			string[] parts = line.split(" = ");
			ulong index = parts[0].split("[")[1][0..$ - 1].to!ulong;
			ulong value = parts[1].to!ulong;
			value &= andMask;
			value |= orMask;
			mem[index] = value;
		}
	}
	ulong total;
	foreach (ulong l; mem.byValue) {
		total += l;
	}
	writeln(total);
}
