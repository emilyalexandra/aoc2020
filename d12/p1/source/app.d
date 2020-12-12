import std.algorithm;
import std.conv;
import std.file;
import std.math;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	int x, y;
	int dir = 0;
	foreach (line; lines) {
		char c = line[0];
		int n = line[1..$].to!int;
		if (c == 'N') y -= n;
		if (c == 'S') y += n;
		if (c == 'E') x += n;
		if (c == 'W') x -= n;
		if (c == 'R') dir += n;
		if (c == 'L') dir -= n;
		if (c == 'F') {
			while (dir < 0) {
				dir += 360;
			}
			while (dir >= 360) {
				dir -= 360;
			}
			if (dir == 0) x += n;
			if (dir == 90) y += n;
			if (dir == 180) x -= n;
			if (dir == 270) y -= n;
		}
	}
	writeln(abs(x) + abs(y));
}
