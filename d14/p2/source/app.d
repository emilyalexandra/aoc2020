import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

ulong[ulong] mem;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	ulong orMask;
	string floatMask;
	foreach (string line; lines) {
		if (line.startsWith("mask = ")) {
			line = line[7..$];
			orMask = line.replace('X', '0').to!ulong(2);
			floatMask = line;
		} else {
			string[] parts = line.split(" = ");
			ulong index = parts[0].split("[")[1][0..$ - 1].to!ulong;
			ulong value = parts[1].to!ulong;
			index |= orMask;
			ulong[] addresses = [index];
			for (ulong i = 0; i < 36; i++) {
				if (floatMask[cast(uint) i] != 'X') continue;
				ulong[] newAddresses;
				foreach (ulong a; addresses) {
					newAddresses ~= a;
					newAddresses ~= a ^ 1L << (35 - i);
				}
				addresses = newAddresses;
			}
			foreach (ulong a; addresses) {
				mem[a] = value;
			}
		}
	}
	ulong total;
	foreach (ulong l; mem.byValue) {
		total += l;
	}
	writeln(total);
}
