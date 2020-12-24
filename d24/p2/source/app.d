import std.algorithm;
import std.file;
import std.math;
import std.stdio;
import std.string;

struct Pos {
	int x, y;

	void move(string dir) {
		if (dir == "e") {
			x++;
		} else if (dir == "w") {
			x--;
		} else {
			if (dir[0] == 's') {
				y++;
				if (dir[1] == 'e') {
					x++;
				}
			} else {
				y--;
				if (dir[1] == 'w') {
					x--;
				}
			}
		}
	}
}

bool[Pos] flipped;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split('\n')[0..$ - 1];
	foreach (string line; lines) {
		Pos p = Pos(0, 0);
		for (int i = 0; i < line.length; i++) {
			char c = line[i];
			if (c == 'e' || c == 'w') {
				p.move(line[i..i + 1]);
			} else {
				p.move(line[i..i + 2]);
				i++;
			}
		}
		if (p in flipped) {
			flipped[p] = !flipped[p];
		} else {
			flipped[p] = true;
		}
	}
	for (int day = 0; day < 100; day++) {
		int[Pos] adj;
		bool[Pos] newFlipped;
		foreach (Pos pos, bool b; flipped) {
			if (!b) continue;
			foreach (string s; ["e", "w", "se", "sw", "ne", "nw"]) {
				Pos t = pos;
				t.move(s);
				adj[t]++;
			}
		}
		foreach (Pos pos, int i; adj) {
			bool b = pos in flipped && flipped[pos];
			if (b) {
				if (i > 0 && i < 3) newFlipped[pos] = true;
			} else {
				if (i == 2) newFlipped[pos] = true;
			}
		}
		flipped = newFlipped;
		int total;
		foreach (bool b; flipped.byValue()) {
			if (b) {
				total++;
			}
		}
	}
	int total;
	foreach (bool b; flipped.byValue()) {
		if (b) {
			total++;
		}
	}
	writeln(total);
}
