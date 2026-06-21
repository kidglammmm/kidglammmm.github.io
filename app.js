document.addEventListener("DOMContentLoaded", () => {
  // 1. Inject Stylesheet programmatically so you don't have to copy it to every page
  const styleLink = document.createElement("link");
  styleLink.rel = "stylesheet";
  styleLink.href = "style.css";
  document.head.appendChild(styleLink);

  // 2. Component Loader Function
  async function loadComponent(elementId, templatePath) {
    const targetElement = document.getElementById(elementId);
    if (!targetElement) return;

    try {
      const response = await fetch(templatePath);
      if (!response.ok) throw new Error(`Failed to fetch ${templatePath}`);
      
      const htmlText = await response.text();
      targetElement.innerHTML = htmlText;

      // Crucial: Manually find and execute scripts inside the injected template
      const scripts = targetElement.querySelectorAll("script");
      scripts.forEach(oldScript => {
        const newScript = document.createElement("script");
        if (oldScript.src) {
          newScript.src = oldScript.src;
        } else {
          newScript.textContent = oldScript.textContent;
        }
        document.body.appendChild(newScript);
        oldScript.remove(); // Clean up the inactive original tag
      });

    } catch (error) {
      console.error(`Error injection component [${elementId}]:`, error);
    }
  }

  // 3. Execute the injections
  loadComponent("global-header", "templates/header.tpl");
  loadComponent("global-footer", "templates/footer.tpl");
});