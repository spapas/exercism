(ns clock)

(defn- fix-minutes
  "To normalize the minutes get the mod 60 and fix negative values"
  [m]
  (let [rem-min (rem m 60)]
    (if (< rem-min 0)
      (+ 60 rem-min)
      rem-min)))

(defn- fix-hours
  "To normalize the hours add the minutes div 60 and then get the mod 24 and fix negative values"
  [h m]
  (let [quot-min (quot m 60)
        rem-hour (if (< m 0) (- quot-min 1) quot-min)
        tot-hour (+ h rem-hour)
        rem-hour (rem tot-hour 24)]
    (if (< rem-hour 0)
      (+ 24 rem-hour)
      rem-hour)))

(defn clock
  "A clock is represented as a vector with normalized hours and minutes"
  [hours minutes]
  [(fix-hours hours minutes) (fix-minutes minutes)])

(defn clock->string
  "Just display the hours and minutes in a clock format"
  [[h m]]
  (format "%02d:%02d" h m))

(defn add-time
  "Adds the minutes and re-normalizes the clock"
  [[h m] time]
  (clock h (+ m time)))
