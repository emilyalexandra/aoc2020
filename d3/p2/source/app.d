module app;

import std.file;
import std.stdio;
import std.string;

void main() {
	int[][] increments = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]];
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	ulong total = 1; // Multiplication
	foreach (int[] inc; increments) {
		total *= howManyTrees(lines, inc[0], inc[1]);
	}
	writeln(total);
}

int howManyTrees(string[] lines, int xInc, int yInc) {
	int x = 0, y = 0;
	int count = 0;
	while (y < lines.length) {
		if (lines[y][x] == '#') count++;
		x += xInc;
		y += yInc;
		if (x >= lines[0].length) x -= lines[0].length;
	}
	return count;
}
