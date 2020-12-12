module app;

import std.algorithm;
import std.conv;
import std.file;
import std.math;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	int wx = 10, wy = -1;
	int x, y;
	foreach (line; lines) {
		char c = line[0];
		int n = line[1..$].to!int;
		if (c == 'N') wy -= n;
		if (c == 'S') wy += n;
		if (c == 'E') wx += n;
		if (c == 'W') wx -= n;
		if (c == 'R') {
			while (n > 0) {
				int yl = wy;
				wy = wx;
				wx = yl * -1;
				n -= 90;
			}
		}
		if (c == 'L') {
			while (n > 0) {
				int xl = wx;
				wx = wy;
				wy = xl * -1;
				n -= 90;
			}
		}
		if (c == 'F') {
			x += n * wx;
			y += n * wy;
		}
	}
	writeln(abs(x) + abs(y));
}
