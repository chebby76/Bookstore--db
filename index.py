class PeterKiprotich:
    def __init__(self):
        self.title = "Full-Stack Developer & UI/UX Engineer"
        self.skills = {
            'frontend': ['React', 'Vue', 'Flutter', 'Figma'],
            'backend': ['Python', 'Node.js', 'Django', 'Firebase'],
            'design': ['UX Research', 'Wireframing', 'Prototyping', 'Adobe XD']
        }
        self.motto = "Clean Code × Beautiful Interfaces"
    
    def build(self, project):
        return f"🚀 Crafting {project} with precision & pixel-perfect design!"
    
    def __str__(self):
        return "Code + Creativity = Digital Magic ✨"


# Instantiate Excellence
dev = PeterKiprotich()
print(dev)  # Output: "Code + Creativity = Digital Magic ✨"