document.addEventListener('turbo:load', () => {
  const citySelect = document.getElementById('citySelect');
  if (citySelect) {
    const citiesData = JSON.parse(citySelect.getAttribute('data-json'));

    document.getElementById('prefectureSelect').addEventListener('change', function (e) {
      const areaId = e.target.value;

      const filteredCities = citiesData.filter(city => city.area1_id == areaId);

      citySelect.innerHTML = '<option value=""></option>';
      filteredCities.forEach(city => {
        const option = document.createElement('option');
        option.value = city.id;
        option.textContent = city.city;
        citySelect.appendChild(option);
      });
    });
  }
});
