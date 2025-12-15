<h1 align="center">Chapter 1. DevOps Basics</h1>
<br>

<h2 align="center">What is DevOps?</h2>

DevOps is a combination of two traditional roles in tech: **Development (Dev)** and **Operations (Ops)** to improve how software is built, deployed, and maintained.

Earlier, developers and operations engineers worked in silos. Developers focused on building applications, while operations teams were responsible for deploying, maintaining, and supporting them in production. This separation often caused delays, miscommunication, and deployment issues.

In the late 2000s, the concept of **DevOps** emerged to bridge this gap.

DevOps is a **practice and culture** where development and operations teams work together throughout the **entire service lifecycle** — from design and development to deployment, monitoring, and production support. It covers both **application-level** and **system-level** responsibilities.


### DevOps consists of Values -> Principles -> Practices -> Tools

---

<h2 align="center"> DevOps Values – CAMS </h2>

<p align="center">
  <img src="./assets/images/CAMS.png" alt="CAMS" width="500"/>
</p>


**CAMS** is a DevOps values model created by **John Willis** and **Damon Edwards**.  
It stands for **Culture, Automation, Measurement, and Sharing**.

### C – Culture
DevOps is primarily a **people problem**, not a technology problem.  
Earlier, development and operations teams worked in silos with conflicting goals, which caused friction and poor outcomes.  
DevOps culture focuses on **collaboration, shared responsibility, and mutual understanding** to improve overall business results.

### A – Automation
Automation helps remove manual work, reduce errors, and increase speed.  
However, automation alone is **not DevOps**.  
Once the right culture is in place, automation acts as an **accelerator** for building, deploying, and managing systems efficiently.

### M – Measurement
Measurement helps teams understand what is actually happening in systems and processes.  
DevOps emphasizes measuring **meaningful outcomes**, such as deployment frequency, recovery time, cost, and customer or employee satisfaction, instead of tracking the wrong or misleading metrics.

### S – Sharing
Sharing promotes collaboration and continuous learning.  
This includes sharing knowledge, ideas, metrics, and problems through documentation, reviews, mentoring, and open communication.  
Transparency makes teams stronger and improves both technical and business outcomes.

**In short:**  
CAMS reminds us that DevOps is about **changing behavior**, using **automation to move faster**, **measuring to improve**, and **sharing to build better services together**.

---

<h2 align="center"> DevOps principles: The Three Ways </h2>

<p align="center">
  <img src="./assets/images/principles.png" alt="principles" width="500"/>
</p>

The **Three Ways of DevOps** are guiding principles created by **Gene Kim** and **Mike Orzen**.  
They explain how to turn DevOps values (CAMS) into real, working practices.

### 1. The First Way – Systems Thinking & Flow
Focus on the **entire system**, not individual teams or components.

Optimizing one part of the system in isolation can hurt overall performance.  
DevOps emphasizes improving the **end-to-end flow** of work — from idea to customer — by reducing silos, handoffs, and bottlenecks.

👉 Value is created only when software reaches the customer successfully.

### 2. The Second Way – Amplifying Feedback Loops
Create **fast and continuous feedback** between teams and systems.

The sooner problems are detected, the cheaper and easier they are to fix.  
Short feedback loops (tests, monitoring, reviews) improve quality, speed, and reliability across development and operations.

👉 Faster feedback = better decisions and less waste.

### 3. The Third Way – Continuous Experimentation & Learning
Encourage a culture of **learning by doing**.

Teams should experiment, fail fast, learn from mistakes, and continuously improve.  
This principle promotes innovation, skill growth, and constant refinement of processes and tools.

👉 Repeated practice and experimentation lead to mastery.

**In summary:**  
The Three Ways guide DevOps teams to **optimize the whole system**, **learn quickly through feedback**, and **continuously improve through experimentation**.

---

<h2 align="center">The Five Practices of DevOps</h2>

<p align="center">
  <img src="./assets/images/practise.png" alt="practise" width="500"/>
</p>

Unlike Agile, DevOps does not follow a single prescriptive framework.  
Instead, common patterns have emerged that form a **DevOps practice playbook** built on **five key practice areas**.

### 1. Culture
Create a safe and stable environment where people can **collaborate, learn, experiment, and even fail**.  
Culture is the foundation of DevOps and focuses on people, trust, and shared responsibility.

### 2. Process
Adopt **Agile and Lean** practices to improve how work flows.
Key practices include:
- Small batch sizes  
- Limiting work in progress  
- Fast feedback loops  
- Lightweight change approvals  

These processes align with the **Three Ways of DevOps** and directly impact business success.

### 3. Infrastructure as Code (IaC)
Manage infrastructure using **code instead of manual actions**.
By using cloud services, containers, and programmable infrastructure, teams gain:
- Reproducibility  
- Self-service  
- Faster scaling and recovery  

### 4. Continuous Delivery (CD)
Automate testing and deployment to release **small, frequent changes**.
Continuous Delivery improves:
- Speed  
- Quality  
- Reliability  
- Team confidence  

It is one of the most impactful DevOps practices.

### 5. Site Reliability Engineering (SRE)
Apply an engineering approach to **reliability and operations**.
SRE focuses on:
- Building reliability into systems  
- Observability and monitoring  
- Automation in operations  

```
These five practice areas **must evolve together**.  
Focusing on one while ignoring others leads to poor results and instability.

**DevOps maturity comes from balancing and iterating across all five pillars.**
```

---

<h2 align="center">DevOps Tool Guidance</h2>

DevOps is **not tool-first**.  

A core DevOps principle is:

```
People → Process → Tools
```
This means:
1. Identify the people responsible and support them properly  
2. Define clear and effective processes  
3. Only then choose tools that best fit those needs  

There is **no single “best” DevOps tool** — only the best tool for your specific organization and use case.

### Key Principles for Choosing DevOps Tools

#### 1. People Over Process Over Tools <br>
Tools should improve **collaboration and sharing**, not just individual productivity.  
The best tools are those that **everyone in the value stream can use effectively**.

#### 2. Keep It Simple (KISS Principle) <br>
Every tool adds complexity:
- Learning
- Maintenance
- Security
- Integration

Using too many tools slows teams down.   <br>
More tools ≠ better DevOps.

👉 Simple, well-integrated tools beat large, complex tool stacks.

#### 3. Build a Toolchain, Not Isolated Tools
DevOps tools must **integrate well** with each other.
Build pipelines where:
- Build tools
- Deployment tools
- Observability tools
- Infrastructure tools  

work together as a **single toolchain**.

Good tools are composable, like Linux commands that can be chained together.

#### 4. Support Dynamic Environments
Modern systems are dynamic (cloud, containers, auto-scaling).
Tools must:
- Adapt automatically
- Expose APIs
- Avoid manual configuration like fixed IPs

Static tools break in modern DevOps environments.

### Final Takeaway
Choose tools that:
- Fit your people and processes  
- Promote collaboration and sharing  
- Stay simple  
- Integrate easily  
- Adapt to change  

**DevOps success comes from how tools are used — not how many you use.**



---
---



<h1 align="center">Chapter 2. DevOps and People: A Culture Change</h1>
<br>

DevOps is fundamentally a **culture change** focused on people, not just tools or automation.  
To remove silos and the “wall of confusion,” organizations must improve how people work together.

<h2 align="center"> The Three Cs of a DevOps Culture </h2>

### 1. Communication
- Encourage open, two-way communication across teams
- Replace handoffs with shared understanding
- Make goals, progress, and issues visible
> Reduces misunderstandings and delays.

### 2. Collaboration
- Development, operations, QA, security, and business teams work as **one unit**
- Shared ownership of outcomes, not isolated responsibilities
- Promotes trust and accountability
> Breaks silos and aligns teams toward business goals.

### 3. Continuous Learning
- Learn from failures instead of blaming
- Encourage experimentation and skill improvement
- Adapt processes based on feedback and results
> Enables continuous improvement and innovation.

---

<h2 align="center">Communication and Trust Power DevOps</h2>

DevOps succeeds only when teams **communicate well and trust each other**.  
Without this, tools and automation fail.

- Clear, intentional communication reduces silos
- Transparency builds trust and fast feedback
- High-trust (generative) teams focus on shared goals

**In short:** communication creates trust, and trust enables DevOps.

<h3 align='center'> Example: Why Tools Alone Don’t Fix DevOps Problems </h3>

In a traditional IT setup, developers needed new servers to continue their work.  
Although creating a server technically took **15 minutes**, the process involved multiple teams, approvals, and handoffs. As a result, getting a server took **several weeks**.

Even after introducing faster technology (virtualization), the delivery time remained slow because **old processes and siloed behavior did not change**.

This highlights the core DevOps lesson:
- The real problem was **culture and process**, not technology
- Silos and handoffs created delays
- Improving tools without changing how people collaborate brought little benefit

DevOps culture focuses on **shared responsibility, better communication, and end-to-end flow**, ensuring that technology improvements actually deliver business value.

---

<h2 align="center">Collaboration: Breaking Silos in DevOps</h2>
DevOps fails when teams work in **silos** with conflicting goals.

### Why Silos Exist
- Developers are rewarded for **speed and change**
- Operations are rewarded for **stability and control**
- These opposing incentives create the **wall of confusion**
- Local team optimization hurts **overall organizational outcomes**

> Silos are caused by **organizational structure and incentives**, not poor people skills.

### Conway’s Law
- Systems reflect communication structures
- Siloed teams lead to siloed, fragile systems
- DevOps aligns teams around the **value stream**

### What Doesn’t Work
- Creating or renaming a team as **DevOps**
- No structural change = no real collaboration

### What Works
- **Cross-functional teams** (Dev + Ops + QA)
- **Shared ownership** of production
- **Self-service automation** instead of ticket handoffs
- **Aligned goals and metrics**

### Outcome
- Faster delivery
- Better feedback loops
- Stronger collaboration
- Shared responsibility

**DevOps collaboration fixes structures and incentives, not just communication.**

---

<h2 align="center"> Kaizen’s Five Guiding Principles  (japnese term: kaizen) </h2>

**Kaizen** supports DevOps by focusing on **continuous improvement**. <br>
(Kaizen emphasizes going to look at the actual place where the value's created or where the problem is, not reports, metrics, processes, or documentation about it. It's actually going to look at it.) <br>

- **Know the customer** → Deliver real business value  
- **Enable smooth workflow** → Reduce bottlenecks and handoffs  
- **Go to gemba** → Observe problems where work actually happens  (gemba: in japnese , it means , the real place)
- **Empower people** → Trust teams and give ownership  
- **Maintain transparency** → Share information and metrics openly

<p align="center">
  <img src="./assets/images/kata.png" alt="kata" width="500"/>
</p>



---
---



<h1 align="center">Chapter 3. DevOps and Process: The Building Blocks</h1>
<br>

DevOps relies on **processes** to streamline work, improve collaboration, and deliver value faster.  
The three main process building blocks are **Agile, Lean, and Visible Ops Change Control**.

---

<h2 align="center"> 1. Agile</h2>

Agile is the first process framework DevOps is rooted in.  

-  Think of Agile as a smarter way to build software (or anything really). Instead of doing everything step by step like Waterfall— requirements → design → coding → testing → release—you do small chunks repeatedly.

- You make a little piece of working software, show it to users or stakeholders, get feedback, then improve it.

- Active collaboration between developers, operations, QA, and even end users.  

- Each iteration produces working software, gets feedback, and informs the next iteration.  

So Agile is basically “iterate, collaborate, learn, repeat.”

<p align="center"> 
  <img src="./assets/images/sdlc.png" alt="sdlc" width="500"/> 
</p>

<h3 align='center'>Teamwork... - Makes the dream work.</h3>

> Agile emphasizes working software, but originally didn't integrate operations — DevOps extends Agile to include ops for service-based systems.

---

<h2 align="center"> 2. Lean </h2>

Lean focuses on **eliminating waste** and only doing things that add real value.

- Originated in manufacturing (Toyota Production System) now applied to software and DevOps..  
- Applied to software development via *Lean Software Development* and *Lean Startup*.   
**Types of Waste (Japanese terms):**  
- Doing stuff that doesn’t add value **(muda)**
- Uneven work or delays **(mura)** 
- Overworking people or systems (muri) 

<p align="center"> 
  <img src="./assets/images/principle_lean.png" alt="principle_lean" width="500"/> 
</p>

<p align="center"> 
  <img src="./assets/images/types_of_waste.png" alt="types_of_waste" width="500"/> 
</p>

**Lean techniques:**  
- **Value stream mapping:** Analyze entire process from idea to delivery  
- **Visual management:** Kanban boards to track work  
- **Limit Work In Progress (WIP):** Reduce multitasking and waste  

<p align="center"> 
  <img src="./assets/images/kanban_board.png" alt="kanban_board" width="500"/> 
</p>

> In short, Lean says: “Stop wasting time and energy. Make the value flow smoothly and continuously.”

---

<h2 align="center">3. Visible Ops Change Control</h2>

Most system failures happen because of changes—adding a feature, patching a bug, or upgrading something. Traditional IT methods like ITIL can slow things down with too many rules and approvals.

**Visible Ops approach::**
1. **Review and document changes**  
   - Peer review for most changes  
   - Escalate high-risk changes for cross-functional approval  
2. **Keep changes small**  
   - Easier to review, test, and fix if issues occur  
3. **Test early and often**  
   - Automated CI testing validates changes before deployment  
   - Security and safeguards integrated early  

> Basically, it’s about managing changes smartly so systems don’t break, without killing speed or innovation.



```
Agile = faster iterations & collaboration

Lean = eliminate waste & smooth workflow

Visible Ops = safe, controlled changes

It’s all about delivering better software faster, safer, and with less friction.
```



---
---



<h1 align="center">Chapter 4. Infrastructure as Code</h1>
<br>