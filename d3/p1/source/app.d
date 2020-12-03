import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];	
	writeln(howManyTrees(lines));
}

int howManyTrees(string[] lines) {
	int x = 0, y = 0;
	int count = 0;
	while (y < lines.length) {
		if (lines[y][x] == '#') count++;
		x += 3;
		y += 1;
		if (x >= lines[0].length) x -= lines[0].length;
	}
	return count;
}
