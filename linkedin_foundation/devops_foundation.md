<h1 align="center">Chapter 1. DevOps Basics</h1>
<br>

<h2 align="center">What is DevOps?</h2>

DevOps combines **Development (Dev)** and **Operations (Ops)** to make software development, deployment, and maintenance faster, smoother, and more reliable.

In the past, developers and operations worked in **silos**. Developers wrote code, operations deployed and managed it. This often caused **delays, miscommunication, and errors**.

DevOps is a **culture and practice** where Dev and Ops teams collaborate throughout the **entire lifecycle** — from design to production support. It covers both **applications** and **systems**.

### DevOps Values → Principles → Practices → Tools

---

<h2 align="center"> DevOps Values – CAMS </h2>

<p align="center">
  <img src="./assets/images/CAMS.png" alt="CAMS" width="500"/>
</p>


**CAMS** stands for **Culture, Automation, Measurement, Sharing**.

### C – Culture
- Focus on people, not just technology  
- Break silos, encourage collaboration and shared responsibility  

### A – Automation
- Removes manual work, reduces errors, speeds up delivery  
- Works best **after culture is established**

### M – Measurement
- Measure meaningful outcomes (deployments, recovery time, satisfaction)  
- Avoid misleading metrics

### S – Sharing
- Promote knowledge sharing, reviews, mentoring, and transparency  
- Builds stronger teams and better results

**Bottom line:** DevOps is about **changing behavior, moving faster with automation, measuring to improve, and sharing knowledge**.

---

<h2 align="center"> DevOps principles: The Three Ways </h2>

<p align="center">
  <img src="./assets/images/principles.png" alt="principles" width="500"/>
</p>


Created by **Gene Kim & Mike Orzen**, the **Three Ways** turn CAMS values into actionable practices.

### 1. First Way – Systems Thinking & Flow
- Focus on the **entire system**, not just teams or tasks  
- Reduce silos, handoffs, and bottlenecks  
- Value is only created when software **successfully reaches the customer**

### 2. Second Way – Amplifying Feedback Loops
- Create **fast, continuous feedback** across teams  
- Catch problems early → cheaper and easier to fix

### 3. Third Way – Continuous Experimentation & Learning
- Encourage **learning by doing**, experimenting, failing fast  
- Improves skills, innovation, and process refinement

**Summary:** Optimize the system, learn quickly from feedback, and keep improving.

---

<h2 align="center">The Five Practices of DevOps</h2>

<p align="center">
  <img src="./assets/images/practise.png" alt="practise" width="500"/>
</p>

Unlike Agile, DevOps isn’t a single framework. It relies on **five key practices**:

### 1. Culture
- Safe, collaborative environment  
- Encourage learning, experimentation, and shared responsibility

### 2. Process
- Use **Agile and Lean** practices  
- Small batch sizes, limited work in progress, fast feedback loops, lightweight approvals

### 3. Infrastructure as Code (IaC)
- Manage infrastructure using **code**, not manual steps  
- Enables reproducibility, self-service, fast scaling

### 4. Continuous Delivery (CD)
- Automate testing and deployment  
- Enables **frequent, small releases** → faster, reliable, and higher quality

### 5. Site Reliability Engineering (SRE)
- Engineering approach to **reliability**  
- Focus on monitoring, automation, and maintaining stable systems
 
> All five pillars must evolve together; focusing on one and ignoring others leads to instability.

---

<h2 align="center">DevOps Tool Guidance</h2>

DevOps is **not about tools first**. The core principle:

```
People → Process → Tools
```
1. Support **people first**  
2. Define **effective processes**  
3. Choose tools that **fit your team and processes** 

### Tool Selection Principles
- **People Over Process Over Tools:** Tools should improve collaboration, not just individual work  
- **Keep It Simple:** Avoid too many tools that increase complexity  
- **Build a Toolchain:** Tools should integrate and flow together  
- **Support Dynamic Environments:** Tools must adapt to cloud, containers, and auto-scaling  

**Key takeaway:** DevOps success depends on **how you use tools**, not how many you use.
> In short: focus on people, support them with clear processes, then add simple, integrated tools.



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