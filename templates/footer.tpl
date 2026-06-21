

<footer id="footer" class="site-footer">
  <div id="footer-dynamic-menu" class="footer-grid"></div>
  <div class="footer-bottom">
    <p>&copy; 2026 All Rights Reserved.</p>
    <!-- Fixed the link syntax below -->
    <p><a href="index.html">Back to Home</a></p>
  </div>
</footer>


<script>
  // Self-invoking function to prevent scope pollution
  (async function() {
    const menuContainer = document.getElementById('footer-dynamic-menu');
    if (!menuContainer) return;

    try {
      // Fetch your JSON configuration file
      const response = await fetch('footer-menu.json');
      if (!response.ok) throw new Error('Could not retrieve footer data.');
      
      const menuItems = await response.json();

      // Dynamically build the template literals string
      const menuHTML = menuItems.map(item => `
	  <div class="footer-item" style="background-color: ${item.backgroundColor || '#222222'}; color: ${item.foregroundColor || '#ffffff'};">
		<h4 style="color: ${item.foregroundColor || '#ffffff'};">${item.title}</h4>
		<p>${item.description}</p>
		<a href="${item.url}" class="footer-btn">
		   ${item.linkText}
		</a>
	  </div>
	`).join('');

      menuContainer.innerHTML = menuHTML;
    } catch (err) {
      console.error('Error loading dynamic footer menu:', err);
      menuContainer.innerHTML = '<p><a href="sitemap.html">Site Navigation</a></p>';
    }
  })();
</script>