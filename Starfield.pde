Particle[] particles;
void setup() {
	size(500, 500);

	particles = new Particle[100];

	for (int i = 0; i < particles.length; i++) {
		particles[i] = new Particle();
	}

	particles[0] = new OddballParticle();
}

void draw() {
	background(177);
	for (Particle particle : particles) {
		particle.draw();

		if (keyPressed) {
			switch(key) {
				case 'w':
				particle.rotateX(PI/32.0);
				break;
				case 's': 
				particle.rotateX(-PI/32.0);
				break;
				case 'a': 
				particle.rotateY(PI/32.0);
				break;
				case 'd': 
				particle.rotateY(-PI/32.0);
				break;
				case 'q': 
				particle.rotateZ(PI/32.0);
				break;
				case 'e': 
				particle.rotateZ(-PI/32.0);
				break;
			}
		}
	}
}

class Particle {
	protected float x, y, z, velocity, rotation, direction;

	public Particle(float x, float y, float z) {
		this.x = x;
		this.y = y;
		this.z = z;

		velocity = random(20) - 10;
		rotation = random(TWO_PI);
		direction = random(TWO_PI);
	}

	public Particle() {
		this(0,0,0);
	}

	public void draw() {
		float vX, vY, vZ;
		vX = velocity * cos(direction) * sin(rotation);
		vY = velocity * cos(rotation) * cos(direction);
		vZ = velocity * sin(rotation);
		
		x += vX;
		y += vY;
		z += vZ;

		velocity *= velocity > 0.05 ? .99 : 1;

		fill(0);
		noStroke();
		ellipse(x + width/2, y + height/2, 5, 5);
	}

	public void rotateY(float theta) {
		x = x * cos(theta) + z * sin(theta);
		z = - x * sin(theta) + z * cos(theta);

	}

	public void rotateX(float theta) {
		y = y * cos(theta) - z * sin(theta);
		z = y * sin(theta) + z * cos(theta);
	}

	public void rotateZ(float theta) {
		x = x * cos(theta) - y * sin(theta);
		y = x * sin(theta) + y * cos(theta);
	}
}

class OddballParticle extends Particle {
	public OddballParticle() {
		super();
	}
}

void mousePressed() {
	for (int i = 0; i < particles.length; i++) {
		particles[i] = new Particle();
	}
}
