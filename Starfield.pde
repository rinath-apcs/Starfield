Particle[] particles;
float distance;

void setup() {
	size(500, 500);
	distance = 700;

	particles = new Particle[100];

	for (int i = 0; i < particles.length; i++) {
		particles[i] = new Particle();
	}

	particles[0] = new OddballParticle();
}

void draw() {
	println(distance);

	background(177,177,177,19);

	if (keyPressed) {
		switch(key) {
			case ' ':
			distance++;
			break;
			case BACKSPACE:
			distance--;
			break;
		}
	}
	
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
	particles[0].draw();
}

class Particle {
	protected float x, y, z, velocity, azumith, theta;

	public Particle(float x, float y, float z) {
		this.x = x;
		this.y = y;
		this.z = z;

		velocity = random(20) - 10;
		azumith = random(TWO_PI);
		theta = random(TWO_PI);
	}	

	public Particle() {
		this(0,0, width / 2.0);
	}

	public void draw() {
		float vX, vY, vZ;
		vX = velocity * cos(azumith) * sin(theta);
		vY = velocity * sin(azumith) * sin(theta);
		vZ = velocity * cos(theta);
		
		x += vX;
		y += vY;
		z += vZ;
 
		velocity *= 0.95;
		noStroke();
		int radius = 5;
		ellipse(x + width / 2.0, y + height / 2.0, radius, radius);
	}

	public void rotateX(float theta) {
		y = y * cos(theta) - z * sin(theta);
		z = y * sin(theta) + z * cos(theta);
	}

	public void rotateY(float theta) {
		x = x * cos(theta) + z * sin(theta);
		z = - x * sin(theta) + z * cos(theta);
	}

	public void rotateZ(float theta) {
		x = x * cos(theta) - y * sin(theta);
		y = x * sin(theta) + y * cos(theta);
	}
}

class OddballParticle extends Particle {
	public OddballParticle() {
		super();
		velocity = 0;
	}

	@Override
	public void draw() {
		fill(0, 255, 0);
		super.draw();
		fill(0);
	}

}

void mousePressed() {
	for (int i = 0; i < particles.length; i++) {
		particles[i] = new Particle();
	}
	particles[0] = new OddballParticle();

}
