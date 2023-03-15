import { Controller } from "@hotwired/stimulus"
import { clippingParents } from "@popperjs/core"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    customMarker: Object
  }


  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#addLocationMarkerToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  #addLocationMarkerToMap() {
    const customMarker = document.createElement("div")
    customMarker.innerHTML = this.customMarkerValue.marker_html

    new mapboxgl.Marker(customMarker)
        .setLngLat([ this.customMarkerValue.lng, this.customMarkerValue.lat ])
        .addTo(this.map)
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    bounds.extend([ this.customMarkerValue.lng, this.customMarkerValue.lat ])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
